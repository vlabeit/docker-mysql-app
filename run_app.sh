#!/bin/bash

echo "Start app script..."

# sudo docker-compose up --build -d


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

echo "1. Create User sh"
echo "2. Create User py"
echo "3. List users sh"
echo "4. List users py"


echo "Enter your selection:"
read selection


case $selection in
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
        echo "Invalid input. Please provide a number (1 - 4)."
        exit 1
        ;;
esac


# echo "1. Create User"
# echo "2. List users"


# echo "Enter your selection:"
# read selection

# if [ "$selection" == "1" ]; then
#     sudo docker exec -it app /decoya/app/create_user.sh
# elif [ "$selection" == "2" ]; then
#     sudo docker exec -it app /decoya/app/read_users.sh
# else
#     echo "Invalid selection. Please enter 1 or 2."
# fi