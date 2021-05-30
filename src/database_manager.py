import pymysql
import aiomysql
import json
import stdiomask
import argon2
import secrets
import time
from typing import List
from logger import Logger
from fatalexception import FatalException

class DatabaseManager:
	def __init__(self, logger: Logger, loop):
		self.logger = logger
		self.db_connection_pool = None
		self.messages_db_connection_pool = None
		self.loop = loop
		self.message_delimiter = "\r\n\r\n"

		with open("server_config.json") as config_file:
			data = json.load(config_file)
			
			self.db_address = data["database_config"]["address"]
			self.db_port = data["database_config"]["port"]
			self.db_name = data["database_config"]["database_name"]
			self.messages_db_name = data["database_config"]["messages_database_name"]
			self.room_id_holder_table_name = data["database_config"]["room_id_holder_table_name"]
			self.db_users_table_name = data["database_config"]["users_table_name"]
			self.cookies_table_name = data["database_config"]["cookies_table_name"]

		self.mysql_username = input("Please enter your MySQL username: ")
		self.mysql_password = stdiomask.getpass(prompt="Please enter your MySQL password: ", mask="*")

	async def start_database_session(self):
		try:
			self.db_connection_pool = await aiomysql.create_pool(host=self.db_address, port=self.db_port, user=self.mysql_username, password=self.mysql_password, 
														 db=self.db_name, loop=self.loop, autocommit=True)
			self.messages_db_connection_pool = await aiomysql.create_pool(host=self.db_address, port=self.db_port, user=self.mysql_username, 
														password=self.mysql_password, db=self.messages_db_name, loop=self.loop, autocommit=True)
		except pymysql.err.OperationalError as e:
			if e.args[0] == 2003:
				self.logger.error("Cannot connect to the database. Please check your credentials or the status of your MySQL server.")
				raise FatalException
		except pymysql.err.InternalError:
			self.logger.error(f"Database '{self.db_name}' or '{self.messages_db_name}' does not exist. Please edit field 'database_name' or " \
							"'messages_db_name' in server_config.json accordingly, or create the database.")
			raise FatalException
		else:
			self.logger.success(f"Successfully connected to the database '{self.db_name}'!")
			self.logger.success(f"Successfully connected to the database '{self.messages_db_name}'")

	async def register_new_user(self, username: str, password: str) -> str:
		is_successful = None
		password_hasher = argon2.PasswordHasher()

		success_json = {"message-type": "registration-confirmation", "success": True}
		failure_json = {"message-type": "registration-confirmation", "success": False, "failure-reason": ""} # Field "failure-reason" will be edited accordingly.

		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				# Check if user already exists.
				await cursor.execute(f"select * from {self.db_users_table_name} where username='{username}'")
				result = await cursor.fetchone()

				if result is None: # User does not exist, register them to the database.
					try:
						hashed_password = password_hasher.hash(password)
					except argon2.exceptions.HashingError:
						failure_json["failure-reason"] = "Error occured while hashing the supplied password."
						is_successful = False
					else:
						empty_friends_json = '{"friends": []}'
						empty_friend_requests_json = '{"friend_requests": []}'
						await cursor.execute("insert into {} (username, password_hash, created_at, friends, friend_requests) " \
											"values('{}', '{}', NOW(), '{}', '{}')".format(self.db_users_table_name, username, 
																							hashed_password, empty_friends_json, empty_friend_requests_json))

						is_successful = True
				else: # Username already exists, return error.
					failure_json["failure-reason"] = "Username already exists in the database."
					is_successful = False


		if is_successful:
			return json.dumps(success_json)
		else:
			return json.dumps(failure_json)

	async def check_login_info(self, username: str, password: str, writer_objects: dict) -> str:
		is_successful = None
		password_hasher = argon2.PasswordHasher()

		success_json = {"message-type": "login-authentication", "success": True, "friends": [], 
						"friend-requests": [], "cookie": ""} # Fields "friends", "friend-requests" and "cookie" will be edited on successful login.
		failure_json = {"message-type": "login-authentication", "success": False, "failure-reason": ""} # Field "reason" will be edited accordingly.

		# Check if this user is already online.
		if username in writer_objects:
			failure_json["failure-reason"] = "This account is already logged in!"

			data_for_user = {"message-type": "forced-logout", 
							"reason": "You are forced to log out because another client has attempted to log into your account."}

			is_sent = await self.send_notification(username, json.dumps(data_for_user), writer_objects)

			if is_sent: # There really was a user logged in with these credentials, so we don't allow this client to log in.
				await self.delete_cookie(username)
				writer_objects.pop(username)
				return json.dumps(failure_json)
		
		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				# Check if user exists.
				await cursor.execute(f"select password_hash from {self.db_users_table_name} where username='{username}'")
				result = await cursor.fetchone()

				if result is None: # User does not exist, return error.
					failure_json["failure-reason"] = "No such user exists in the database."
					is_successful = False
				else:
					user_stored_password_hash = result[0]

					try:
						verify_success = password_hasher.verify(user_stored_password_hash, password)

						if verify_success: # Login successful, return user data.
							await cursor.execute(f"select friends, friend_requests from {self.db_users_table_name} where username='{username}'")
							query_result = await cursor.fetchone()

							friends_json = json.loads(query_result[0])
							friend_requests_json = json.loads(query_result[1])

							cookie = await self.register_new_cookie(username)

							success_json["friends"].extend(friends_json["friends"])
							success_json["friend-requests"].extend(friend_requests_json["friend_requests"])
							success_json["cookie"] = cookie

							is_successful = True

					except argon2.exceptions.VerifyMismatchError: # Login failed, return error.
						failure_json["failure-reason"] = "Invalid password given."
						is_successful = False


		if is_successful:
			return json.dumps(success_json)
		else:
			return json.dumps(failure_json)

	async def friend_request_handler(self, sender: str, recipient: str, cookie: str, writer_holder: dict) -> str:
		is_successful: bool = None

		success_json = {"message-type": "friend-request-result", "success": True}
		failure_json = {"message-type": "friend-request-result", "success": False, "reason": ""} # Field "reason" will be edited later.

		is_valid_cookie = await self.check_cookie_validity(sender, cookie)

		if not is_valid_cookie:
			failure_json["reason"] = "Invalid cookie supplied. If you're not trying something fishy, please try relogging."
			is_successful = False
		else:
			async with self.db_connection_pool.acquire() as connection:
				async with connection.cursor() as cursor:
					await cursor.execute(f"select * from {self.db_users_table_name} where username='{recipient}'") # First, check if user exists.
					query_result = await cursor.fetchone()

					if query_result is None:
						failure_json["reason"] = "No such user exists."
						is_successful = False
					else:
						recipient_friends = json.loads(query_result[4])
						recipient_friend_requests = json.loads(query_result[5])

						if sender in recipient_friends["friends"]: # Check if sender and recipient are already friends.
							failure_json["reason"] = "This person is already your friend!"
							is_successful = False
						elif sender in recipient_friend_requests["friend_requests"]: # Check if sender already sent a friend request to this person.
							failure_json["reason"] = "You already have a pending friend request for this person!"
							is_successful = False
						else:
							recipient_friend_requests["friend_requests"].append(sender)
							recipient_new_friend_requests = json.dumps(recipient_friend_requests)
							await cursor.execute(f"update {self.db_users_table_name} set friend_requests='{recipient_new_friend_requests}' " \
												f"where username='{recipient}'")

							data_for_recipient = {"message-type": "new-friendship-request", "sent-by": sender, "sent-at": int(time.time())}

							await self.send_notification(recipient, json.dumps(data_for_recipient), writer_holder)

							is_successful = True


		if is_successful:
			return json.dumps(success_json)
		else:
			return json.dumps(failure_json)

	async def friend_request_response_handler(self, request_recipient: str, request_sender: str, sender_cookie: str, 
										   is_accepted: bool, writer_holder: dict) -> None:
		data_for_sender = {"message-type": "friend-request-update", "request-recipient": request_recipient, "is_accepted": is_accepted}

		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				if is_accepted:
					# Get sender's user data and update it accordingly.
					await cursor.execute(f"select friends from {self.db_users_table_name} where username='{request_sender}'")
					query_result = await cursor.fetchone()

					sender_friends = json.loads(query_result[0])

					sender_friends["friends"].append(request_recipient)

					await cursor.execute(f"update {self.db_users_table_name} set friends='{json.dumps(sender_friends)}' where username='{request_sender}'")
			
					# Get recipient's user data and update it accordingly.
					await cursor.execute(f"select friends, friend_requests from {self.db_users_table_name} where username='{request_recipient}'")
					query_result = await cursor.fetchone()

					recipient_friends = json.loads(query_result[0])
					recipient_friend_requests = json.loads(query_result[1])

					recipient_friends["friends"].append(request_sender)
					recipient_friend_requests["friend_requests"].remove(request_sender)

					await cursor.execute(f"update {self.db_users_table_name} set friends='{json.dumps(recipient_friends)}', " \
										f"friend_requests='{json.dumps(recipient_friend_requests)}' where username='{request_recipient}'")
				else:
					# Get recipient's data and update it accordingly.
					await cursor.execute(f"select friend_requests from {self.db_users_table_name} where username='{request_recipient}'")
					query_result = await cursor.fetchone()

					recipient_friend_requests = json.loads(query_result[0])
				
					recipient_friend_requests["friend_requests"].remove(request_sender)

					await cursor.execute(f"update {self.db_users_table_name} set friend_requests='{json.dumps(recipient_friend_requests)}' " \
										f"where username='{request_recipient}'")


			await self.send_notification(request_sender, json.dumps(data_for_sender), writer_holder)

	async def remove_friend(self, deleter: str, deleted: str, deleter_cookie: str, writer_objects: dict) -> str:
		is_successful: bool = None
		success_json = {"message-type": "friend-deletion-update", "deleted-user": deleted, "success": True}
		failure_json = {"message-type": "friend-deletion-update", "deleted-user": deleted, "success": False, "reason": ""} # Field "reason" will be updated accordingly later.

		is_valid_cookie = await self.check_cookie_validity(deleter, deleter_cookie)

		if not is_valid_cookie:
			failure_json["reason"] = "Invalid cookie supplied!"
			is_successful = False
		else:
			async with self.db_connection_pool.acquire() as connection:
				async with connection.cursor() as cursor:
					# Update deleter's friends list.
					await cursor.execute(f"select friends from {self.db_users_table_name} where username='{deleter}'")
					query_result = await cursor.fetchone()

					deleter_friends = json.loads(query_result[0])
					deleter_friends["friends"].remove(deleted)

					await cursor.execute(f"update {self.db_users_table_name} set friends='{json.dumps(deleter_friends)}' where username='{deleter}'")

					# Update deleted's friends list.
					await cursor.execute(f"select friends from {self.db_users_table_name} where username='{deleted}'")
					query_result = await cursor.fetchone()

					deleteds_friends = json.loads(query_result[0])
					deleteds_friends["friends"].remove(deleter)

					await cursor.execute(f"update {self.db_users_table_name} set friends='{json.dumps(deleter_friends)}' where username='{deleted}'")

					is_successful = True


		if is_successful:
			data_for_deleted = {"message-type": "deleted-by-friend", "deleted-by": deleter}
			await self.send_notification(deleted, json.dumps(data_for_deleted), writer_objects)

			return json.dumps(success_json)
		else:
			return json.dumps(success_json)

	async def handle_message(self, sender: str, sender_cookie: str, recipient: str, message_content: str, writer_holder: dict) -> None:
		data_for_recipient = {"message-type": "new-message", "sent-by": sender, "message-content": message_content, "sent-at": int(time.time())}

		is_valid_cookie = await self.check_cookie_validity(sender, sender_cookie)

		if is_valid_cookie:
			await self.store_message(sender, recipient, message_content)
			await self.send_notification(recipient, json.dumps(data_for_recipient), writer_holder)

	async def get_message_table_id(self, user_a: str, user_b: str) -> int:
		room_id = None

		async with self.messages_db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				table_check_query = f"select room_id from {self.room_id_holder_table_name} where participant_a='{user_a}' and participant_b='{user_b}' " \
									f"or participant_a='{user_b}' and participant_b='{user_a}'"
				await cursor.execute(table_check_query)
				table_check_query_result = await cursor.fetchone()

				if table_check_query_result is None:
					table_registration_query = f"insert into {self.room_id_holder_table_name} (participant_a, participant_b) values ('{user_a}', '{user_b}')"
					await cursor.execute(table_registration_query)

					await cursor.execute(table_check_query)
					query_result = await cursor.fetchone()
					room_id = query_result[0]

					# Now we create the table.
					table_creation_query = f"create table chatroom_{room_id} (message_id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT," \
											"message_content VARCHAR(2000), sent_by VARCHAR(32), sent_at BIGINT UNSIGNED)"
					await cursor.execute(table_creation_query)
				else:
					room_id = table_check_query_result[0]


		return room_id

	async def store_message(self, sender: str, recipient: str, message_content: str) -> None:
		async with self.messages_db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				room_id = await self.get_message_table_id(sender, recipient)

				message_insertion_query = f"insert into chatroom_{room_id} (message_content, sent_by, sent_at) values (%s, '{sender}', " \
											f"{int(time.time())})" # Using bind variables because PyMySQL conforms the Python DBI.
				await cursor.execute(message_insertion_query, message_content)

	# max_index param does nothing. The plan was to make it so that you would be able to load older messages on the client, but I got too lazy to implement that.
	async def fetch_messages(self, requester: str, requester_cookie: str, other_participant: str, max_index: int) -> str:
		success_json = {"message-type": "fetch-messages-request-response", "success": True, "user": other_participant, 
						"max_index": max_index, "messages": []} # Field "messages" will be filled with JSON that contain unix timestamp, message content and sender.
		failure_json = {"message-type": "fetch-messages-request-response", "success": False, "user": other_participant, "reason": ""} # Field "reason" will be filled accordingly on failure.

		is_valid_cookie = await self.check_cookie_validity(requester, requester_cookie)
		if not is_valid_cookie:
			failure_json["reason"] = "Invalid cookie supplied!"
			return json.dumps(failure_json)

		room_id = await self.get_message_table_id(requester, other_participant)

		async with self.messages_db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				# max_message_index = max_index
				# min_message_index = int(max_index) - 100
				fetch_messages_query = f"select sent_at, sent_by, message_content from chatroom_{room_id} order by message_id desc limit 100"
				await cursor.execute(fetch_messages_query)
				query_result = await cursor.fetchall()

				for result in query_result:
					message_json_obj = {"sent-at": 0, "sent-by": "", "message-content": ""}
					message_json_obj["sent-at"] = result[0]
					message_json_obj["sent-by"] = result[1]
					message_json_obj["message-content"] = result[2]

					success_json["messages"].append(json.dumps(message_json_obj))

		return json.dumps(success_json)

	# Checks if there's an active connection to a user. Returns false if there is none.
	async def is_online(self, username: str, writer_objects: dict) -> bool:
		message = json.dumps({"message-type": "dummy-message"})
		is_sent = await self.send_notification(username, message, writer_objects)

		return True if is_sent else False

	async def check_status_of_friends(self, friends: List[str], writer_objects: dict):
		response = {"message-type": "get-statuses-response", "is_friend_online": {}} # Field "is_online" will be filled with user's friends' statuses.

		for friend in friends:
			status = await self.is_online(friend, writer_objects)
			response["is_friend_online"][friend] = status

		return json.dumps(response)
	
	# Returns true if the user was online and the message was sent, otherwise returns false.
	async def send_notification(self, recipient: str, data: str, writer_holder: dict) -> bool:
		if recipient not in writer_holder:
			return False
		else:
			try:
				writer_holder[recipient].write((data + self.message_delimiter).encode("utf8"))
				await writer_holder[recipient].drain()
				return True
			except (ConnectionResetError, OSError):
				writer_holder.pop(recipient)
				return False

	async def register_new_cookie(self, username: str) -> str:
		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				generated_cookie = secrets.token_urlsafe(32)

				await cursor.execute("select cookie from {} where username='{}'".format(self.cookies_table_name, username))
				query_result = await cursor.fetchone()

				if query_result is None: # If a past cookie doesn't already exist, add it.
					await cursor.execute("insert into {} values('{}', '{}')".format(self.cookies_table_name, username, generated_cookie))
				else: # If a past cookie exists somehow, update it.
					await cursor.execute("update {} set cookie='{}' where username='{}'".format(self.cookies_table_name, generated_cookie, username))

				return generated_cookie

	async def check_cookie_validity(self, username: str, supplied_cookie: str) -> bool:
		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				await cursor.execute("select cookie from {} where username='{}'".format(self.cookies_table_name, username))
				query_result = await cursor.fetchone()

				if query_result is not None:
					current_cookie = query_result[0]
				else:
					return False

				return supplied_cookie == current_cookie

	async def delete_cookie(self, username: str):
		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				await cursor.execute("delete from {} where username='{}'".format(self.cookies_table_name, username))


	async def delete_all_cookies(self):
		async with self.db_connection_pool.acquire() as connection:
			async with connection.cursor() as cursor:
				await cursor.execute("delete from {} where 1".format(self.cookies_table_name))