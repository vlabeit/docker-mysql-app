#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Check if required variables are set
if [ -z "$MYSQL_HOST" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ]; then
    echo "Required variables not found in .env file."
    exit 1
fi

QUERY="SELECT * FROM users;"
#Read data from mysql data and return all users dict list
mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" -e "$QUERY" | while read -r row; do
    echo "$row"
done