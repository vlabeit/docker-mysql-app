#!/bin/bash

# Running scripts for the app

echo "Start app script..."

function start_docker() {
    sudo docker-compose up --build -d
}

function create_user_sh() {
    sudo docker exec -it app /decoya/app/create_user.sh
}

function create_user_py() {
    sudo docker exec -it app ./env/bin/python3 /decoya/app/create_user.py
}

function read_users_sh() {
    sudo docker exec -it app /decoya/app/read_users.sh
}

function read_users_py() {
    sudo docker exec -it app ./env/bin/python3 /decoya/app/read_users.py
}

echo "Enter a number to continue"
echo "0. Start Docker"
echo "1. Create User sh"
echo "2. Create User py"
echo "3. List users sh"
echo "4. List users py"


echo "Enter your selection:"
read selection


case $selection in
    0)
        start_docker
        ;;
    1)
        create_user_sh
        ;;
    2)
        create_user_py
        ;;
    3)
        read_users_sh
        ;;
    4)
        read_users_py
        ;;
    *)
        echo "Invalid input. Please provide a number (0 - 4)."
        exit 1
        ;;
esac