import socket
import ssl
import asyncio
import json
from logger import Logger
from database_manager import DatabaseManager
from fatalexception import FatalException


class Server:
	def __init__(self):
		self.loop = asyncio.get_event_loop()
		self.logger = Logger()
		self.ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
		self.ssl_context.load_cert_chain(certfile="certs/server.crt", keyfile="certs/server.key")
		self.database_manager = DatabaseManager(self.logger, self.loop)
		self.writer_objects = {} # Holds asyncio.StreamWriter objects per username basis for conveying client to client messages.
		self.message_delimiter = "\r\n\r\n"

		with open("server_config.json") as config_file:
			data = json.load(config_file)

			# Server-related variables.
			self.listen_addr = data["server_config"]["listen_addr"]
			self.port = data["server_config"]["port"]
			self.read_buffer_len = data["server_config"]["read_buffer_length"]

	async def start_server(self):
		self.loop.set_exception_handler(self.exception_handler)
		await self.database_manager.start_database_session()
		await self.database_manager.delete_all_cookies() # Remove any leftover cookies in case server was shutdown in an unusual way.
		server = await asyncio.start_server(self.handle_connection, self.listen_addr, self.port, ssl=self.ssl_context)
		
		self.logger.success("Server up and running!")
		async with server:
			await server.serve_forever()

	def exception_handler(self, loop, context):
		exception = context.get("exception")

		if isinstance(exception, FatalException):
			loop.stop()

			try:
				quit(1)
			except SystemExit:
				pass
		else:
			loop.default_exception_handler(context)
		
	async def handle_connection(self, reader, writer):
		self.logger.log(f"Accepted a client from {writer.get_extra_info('peername')}!")

		received = None

		while True:
			try:
				received = (await reader.read(self.read_buffer_len)).decode('utf8') # Await until EOF.
			except ConnectionResetError:
				break

			response = await self.handle_client_request(received, writer) # Passing the asyncio.StreamWriter object - a reference to it will be saved if the login is successful.
			if response is not None:
				try:
					writer.write((response + self.message_delimiter).encode('utf8'))
					await writer.drain()
				except (ConnectionResetError, AttributeError):
					return
	
	# Handle client request based on "message-type". This function returns a JSON-convertible string if the request requires an answer.
	async def handle_client_request(self, request: str, writer: asyncio.StreamWriter) -> str:
		json_object = None
		request_type = None

		unexpected_error = {"message-type": "unexpected-error", "received-type": ""}

		try:
			json_object = json.loads(request)
			request_type = json_object["message-type"]
		except (json.decoder.JSONDecodeError, KeyError):
			return json.dumps(unexpected_error)

		if request_type == "login-request":
			username = None

			try:
				username = json_object["username"]
				password = json_object["password"]
			except KeyError:
				return json.dumps(unexpected_error)
			else:
				result = await self.database_manager.check_login_info(username, password, self.writer_objects)

				if json.loads(result)["success"]: # If the login is successful, save a reference of the asyncio.StreamWriter object.
					self.writer_objects[username] = writer

				return result

		elif request_type == "registration-request":
			try:
				username = json_object["username"]
				password = json_object["password"]
			except:
				return json.dumps(unexpected_error)	
			else:
				return await self.database_manager.register_new_user(username, password)

		elif request_type == "friend-request":
			sender = json_object["from"]
			recipient = json_object["to"]
			cookie = json_object["cookie"]

			return await self.database_manager.friend_request_handler(sender, recipient, cookie, self.writer_objects)

		elif request_type == "send-message":
			sender = json_object["from"]
			sender_cookie = json_object["cookie"]
			recipient = json_object["to"]
			message_content = json_object["message-content"]

			await self.database_manager.handle_message(sender, sender_cookie, recipient, message_content, self.writer_objects)
		
		elif request_type == "friend-request-response":
			request_sender = json_object["request_sender"]
			request_replier = json_object["request_replier"]
			is_accepted = json_object["accepted"]
			cookie = json_object["cookie"]

			return await self.database_manager.friend_request_response_handler(request_replier, request_sender, cookie, is_accepted, self.writer_objects)

		elif request_type == "friend-deletion-request":
			deleter = json_object["username"]
			cookie = json_object["cookie"]
			deleted_person = json_object["deleted-person"]

			return await self.database_manager.remove_friend(deleter, deleted_person, cookie, self.writer_objects)

		elif request_type == "fetch-messages-request":
			requester = json_object["requester"]
			requester_cookie = json_object["cookie"]
			other_participant = json_object["other-participant"]
			max_index = json_object["max_index"]

			return await self.database_manager.fetch_messages(requester, requester_cookie, other_participant, max_index)

		elif request_type == "get-statuses":
			client_friends = json_object["friends"]

			return await self.database_manager.check_status_of_friends(client_friends, self.writer_objects)

		elif request_type == "disconnection-notification" or request_type == "logout-notification":
			username = json_object["username"]
			await self.database_manager.delete_cookie(username)
			try:
				self.writer_objects.pop(username)
			except KeyError:
				pass
			return "disconnected"
		else:
			unexpected_error["received-type"] = request_type
			return json.dumps(unexpected_error)


if __name__ == "__main__":
	server = Server()
	try:
		server.loop.run_until_complete(server.start_server())
	except FatalException:
		server.logger.error("Could not start the server.")