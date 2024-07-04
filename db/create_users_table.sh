#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

#Creating users tabale if doesnt exsist

# Check if required variables are set
if [ -z "$MYSQL_HOST" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ]; then
    echo "Required variables not found in .env file."
    exit 1
fi

mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" <<EOF
CREATE TABLE IF NOT EXISTS users_bash (
    name TEXT,
    age INT
);
EOF