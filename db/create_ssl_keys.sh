#!/bin/bash

echo "Creating SSL keys"

openssl req -x509 -nodes -newkey rsa:4096 -keyout mysql-key.pem -out mysql-cert.pem -days 365 \
  -subj "/C=US/ST=New York/L=New York/O=MyOrg/OU=MyUnit/CN=mysql"
