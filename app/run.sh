#!bin/bash

echo "1. Create User"
echo "2. List users"

echo "Enter your selection:"
read selection

if [ "$selection" == "1" ]; then
    docker exec app /decoya/app/create_user.sh
elif [ "$selection" == "2" ]; then
    docker exec app /decoya/app/read_users.sh
else
    echo "Invalid selection. Please enter 1 or 2."
fi