# konkon_server
### konkon_server is the server part of the chat application Konkon.
[Client repository](https://github.com/emredesu/konkon_client)

#### Usage
1- Install requirements using `pip install -r requirements.txt`

2- [Get MySQL](https://dev.mysql.com/downloads/)

2- Create the _konkon_ and _konkon-messages_ databases following the guidelines on `main_database_structure.txt` and `messages_database_structure.txt` files *OR* import the premade databases from the `premade_databases` folder.

3- Set up `server_config.json` with accordance to the databases you've created (can be left as-is if you imported the included databases)

4- Run `konkon_server.py` with your Python interpreter

5- Log in using your MySQL credentials

##### Server is hosted on localhost with port 27015 by default. Edit `server_config.json` if you would like to change that or other variables such as the database port/address.

##### Certificate files included are signed locally and included to be able to run the server out-of-the-box. They are obviously not secure to use.
