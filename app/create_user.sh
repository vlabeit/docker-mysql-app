#!/bin/bash

# if [ -z "$MYSQL_HOST" ] || [ -z "$MYSQL_ROOT_USER" ] || [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ]; then
#     echo "Required variables not found in .env file."
#     exit 1
# fi

# Function to validate age (must be a number)
age_validation() {
    age=$1
    if ! [[ $age =~ ^[0-9]+$ ]]; then
        echo "Error: Age must be a number."
        exit 1$1
    fi
}

name_validation() {
    name=$1
    # Regex pattern for a basic name validation (alphabetic characters, spaces, apostrophes, and hyphens)
    if [[ ! $name =~ ^[a-zA-Z\ \'-]+$ ]]; then
        return 1
    fi
    return 0
}

# Prompt the user to enter their name and age
echo "Enter your name:"
read name

# Validate  input
name_validation "$name"

echo "Enter your age:"
read age

# Validate age input
age_validation "$age"

# Insert age and name from input to db
mysql -h "$MYSQL_HOST" -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" <<EOF
INSERT INTO users (name, age) VALUES ('$name', $age);
EOF
