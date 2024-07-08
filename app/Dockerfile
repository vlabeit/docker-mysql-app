FROM ubuntu:latest

WORKDIR /home/user/decoya

COPY . ./app
# Update packages and install necessary dependencies
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        default-mysql-client \
        openssh-server \
        python3 \
        python3-pip \
        python3.12-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# permissions update
RUN mkdir -p /home/user/decoya/app/logs \
    && chmod -R 755 /home/user/decoya/app/logs \
    && touch /home/user/decoya/app/logs/logfile.txt \
    && chmod +x /home/user/decoya/app/scripts/*.sh \
    && chmod +x /home/user/decoya/app/*.py \
    && chmod +x /home/user/decoya/app/read_users.sh /home/user/decoya/app/create_user.sh \
    && mkdir -p /run/sshd \
    && chmod 0755 /run/sshd
    
# ssh config
# RUN bash /usr/local/bin/sshd_config.sh
# COPY ./sshd_config.sh /usr/local/bin/sshd_config.sh

# Python environment 
RUN python3 -m venv ./env && \
    chmod +x ./env/bin/activate

SHELL ["/bin/bash", "-c"]
RUN source ./env/bin/activate
RUN ./env/bin/pip install --no-cache-dir \
mysql-connector-python

CMD ["/usr/sbin/sshd", "-D"]

