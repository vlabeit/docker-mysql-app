Docker example with python and bash.

Step 0 – Under the hood
•	All functions in this code implemented in bash and python.
Docker-compose db – 2 scripts that run when container created:
Python –created new container named "create-table" container with script in python to create "users_py" table
bash – created on docker RUN
•	Data mount.
All data mounted with persistent storage with volums.
mysql_data volume for mysql data
Path mount with other files (app files and logs)

Step 1 - running run_vm script
git clone https://github.com/vlabeit/docker-mysql-app.git

•	On windows
  download virtual box and start vm from the provided ova file.
./run_vm.sh
This script will copy all files app to virtual host, install OpenSSH, forward ports and more .
•	On Linux
download virtual box and start vm from the provided ova file.
or / and
./run_vm.sh
This script will copy all files from host to machine if created or create / import new vm on VirtualBox , install OpenSSH, forward ports and more  // not fully completed.

Step 2 - running run_app script
This script connects with ssh to local VirtualBox docker container.
	Start app script...
Enter a number to continue
0. Start Docker
1. Create User sh
2. Create User py
3. List users sh
4. List users py
Enter your selection:

Bonus! 😊
•	Mysql SSL can be created with db/ db/create_ssl_keys.sh or using
openssl req -x509 -nodes -newkey rsa:4096 -keyout mysql-key.pem -out mysql-cert.pem -days 365

and RUN echo "[mysqld]" > /etc/mysql/conf.d/ssl.cnf \
    && echo "ssl-ca=/etc/mysql/mysql-cert.pem" >> /etc/mysql/conf.d/ssl.cnf \
    && echo "ssl-cert=/etc/mysql/mysql-cert.pem" >> /etc/mysql/conf.d/ssl.cnf \
    && echo "ssl-key=/etc/mysql/mysql-key.pem" >> /etc/mysql/conf.d/ssl.cnf

•	Logs – logs of every mysql request logged to persistent folder app/logs

2024-07-03 07:08:38,106 - log_handler - INFO - Connection established, mysql log data: defaultdict(<class 'dict'>, {'ip': '172.18.0.4', 'host': '1b8dffc29389', 'db': 'decoya'})
2024-07-03 07:08:38,167 - log_handler - INFO - Query executed: SELECT * FROM users


