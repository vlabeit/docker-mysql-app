# Docker MySQL App

## Overview

This project demonstrates Docker usage with Python and Bash scripts to manage a MySQL application. It includes features like data persistence, SSH setup, MySQL SSL configuration, and logging.

### Step 0 – Under the Hood

All functionality is implemented using Bash and Python scripts.

- **Docker-Compose db:**
  - **Python:** Creates a new container named "create-table" with a Python script (`create-table.py`) to initialize a "users_py" table.
  - **Bash:** Executes during Docker container creation, handling initial setup.

- **Data Mount:**
  - Utilizes persistent storage with volumes:
    - `mysql_data` for MySQL data.
    - Paths mounted for application files and logs.

### Step 1 - Running `run_vm` Script

follow these steps: 
```
git clone https://github.com/vlabeit/docker-mysql-app.git
```

- **On Windows:**
  1. Download VirtualBox.
  2. Start the VM using the provided OVA file.
  3. Run `./run_vm.sh`.
     - Copies application files to the VirtualBox host.
     - Installs OpenSSH.
     - Sets up port forwarding.

- **On Linux:**
  1. Download VirtualBox.
  2. Start the VM using the provided OVA file or create/import a new VM in VirtualBox.
  3. Run `./run_vm.sh`.
     - Copies application files to the VM.
     - Installs OpenSSH.
     - Configures port forwarding.

### Step 2 - Running `run_app` Script

This script connects via SSH to the local VirtualBox Docker container.

- **Start App Script:**
  - Select an option:
    0. Start Docker.
    1. Create User (Bash).
    2. Create User (Python).
    3. List Users (Bash).
    4. List Users (Python).

### Bonus Features

- **MySQL SSL Setup:**
  - Use `db/create_ssl_keys.sh` or manually with OpenSSL:
    ```
    openssl req -x509 -nodes -newkey rsa:4096 -keyout mysql-key.pem -out mysql-cert.pem -days 365
    ```
  - Update MySQL configuration (`ssl.cnf`):
    ```
    [mysqld]
    ssl-ca=/etc/mysql/mysql-cert.pem
    ssl-cert=/etc/mysql/mysql-cert.pem
    ssl-key=/etc/mysql/mysql-key.pem
    ```

- **Logging:**
  - Logs every MySQL request to a persistent folder (`app/logs`):
    ```
    2024-07-03 07:08:38,106 - log_handler - INFO - Connection established, mysql log data: defaultdict(<class 'dict'>, {'ip': '172.18.0.4', 'host': '1b8dffc29389', 'db': 'decoya'})
    2024-07-03 07:08:38,167 - log_handler - INFO - Query executed: SELECT * FROM users
    ```

This readme provides a structured overview of your Docker MySQL application, making it easier for users to understand and use your project on GitHub.
