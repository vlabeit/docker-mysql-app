FROM mysql:latest as mysql_deploy
WORKDIR /home/user/decoya

COPY ./db ./db

RUN  chmod +x ./db/create_users_table.sh

#######################################################################
# SSL Create 
#######################################################################
RUN  chmod +x ./db/create_ssl_keys.sh

# Copy SSL certificates into the container
COPY mysql-cert.pem /etc/mysql/mysql-cert.pem
COPY mysql-key.pem /etc/mysql/mysql-key.pem

# Set permissions on the certificates (adjust as needed)
RUN chown -R mysql:mysql /etc/mysql/mysql-*.pem \
    && chmod 600 /etc/mysql/mysql-key.pem

# Create ssl-config.cnf with SSL settings
RUN echo "[mysqld]" > /etc/mysql/conf.d/ssl.cnf \
    && echo "ssl-ca=/etc/mysql/mysql-cert.pem" >> /etc/mysql/conf.d/ssl.cnf \
    && echo "ssl-cert=/etc/mysql/mysql-cert.pem" >> /etc/mysql/conf.d/ssl.cnf \
    && echo "ssl-key=/etc/mysql/mysql-key.pem" >> /etc/mysql/conf.d/ssl.cnf

# RUN bash create_users_table.sh

########################################################################
# Create user table container
from python:3.9-slim as create_users_table
RUN apt-get update && apt-get install --no-install-recommends -y default-mysql-client

WORKDIR /home/user/decoya

RUN pip install mysql-connector-python
