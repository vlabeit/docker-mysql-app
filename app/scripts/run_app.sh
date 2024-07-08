#!/bin/bash

# if [ -f /home/user/decoya/.env ]; then
#     export $(cat .env | grep -v '^#' | xargs)
# fi


# if [ -z "$MYSQL_HOST" ] || [ -z "$MYSQL_ROOT_USER" ] || [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ]; then
#     echo "Required variables not found in .env file."
#     exit 1
# fi

base_path="/home/user/decoya/app"

echo "Start decota app script..."

function add_cron() {
    # Creating cron job to show users table once a day
    echo "Creating cron job..."
    SCRIPT_PATH="home/user/decoya/app/read_users.py"
    OUTPUT_DIR="/home/user/decoya/app/logs"

    # Create a temporary cron file and add a new cron job to the temporary file
    crontab -l > cron_file
    # echo "30 15 * * * /home/user/decoya/app/read_users.py > /home/user/decoya/app/logs/$(date +\%Y\%m\%d).log 2>&1" >> cron_file
    # echo "*/5 * * * * \
    # sudo docker exec -it app ./env/bin/python3 $base_path/read_users.py \
    #  > /home/user/decoya/app/logs/$(date +\%Y\%m\%d).log 2>&1" >> cron_file

    echo "*/5 * * * * sudo docker exec -i app /bin/bash -c 'cd $base_path && ./env/bin/python3 read_users.py > /home/user/decoya/app/logs/\$(date +\%Y\%m\%d).log 2>&1'" >> cron_file



    # Install and removing the new cron file
    crontab cron_file
    rm cron_file
    echo "Cron job added successfully."
}

function start_docker() {
    sudo docker-compose up --build -d
}

function create_user_sh() {
    sudo docker exec -it app $base_path/create_user.sh
}

function create_user_py() {
    sudo docker exec -it app ./env/bin/python3 $base_path/create_user.py
}

function read_users_sh() {
    sudo docker exec -it app $base_path/read_users.sh
}

function read_users_py() {
    sudo docker exec -it app ./env/bin/python3 $base_path/read_users.py
}

function connect_mysql() {
    sudo docker exec -it mysql mysql -h $MYSQL_HOST -uroot -p
}

function connect_mysql() {
    sudo docker exec -it mysql mysql -h $MYSQL_HOST -uroot -p
}

function show ssl() {
    sudo docker exec -it mysql mysql -h $MYSQL_HOST -uroot -p -e "SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME IN ('Ssl_version', 'Ssl_cipher');"
}

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}Welcome to decoya app${NC}"
echo -e "${GREEN}--------------------------${NC}"
echo -e "${BLUE}Enter a number to continue${NC}"
echo -e "${YELLOW}0. Start Docker${NC}"
echo -e "${YELLOW}1. Create and start cron job${NC}"
echo -e "${YELLOW}2. Show mysql SSL${NC}"
echo -e "${GREEN}--------------------------${NC}"
echo -e "${YELLOW}3. Create User sh${NC}"
echo -e "${YELLOW}4. Create User py${NC}"
echo -e "${YELLOW}5. List users sh${NC}"
echo -e "${YELLOW}6. List users py${NC}"

echo ""
echo -e "${GREEN}Choose your selection${NC}"
read selection


case $selection in
    0)
        start_docker
        ;;
    1)
        add_cron
        ;;
    2)
        connect_mysql
        ;;
    3)
        create_user_sh
        ;;
    4)
        create_user_py
        ;;
    5)
        read_users_sh
        ;;
    6)
        read_users_py
        ;;
    
    *)
        echo -e "${GREEN}Invalid input. Please provide a number (0 - 6).${NC}"

        echo ""
        exit 1
        ;;
esac

