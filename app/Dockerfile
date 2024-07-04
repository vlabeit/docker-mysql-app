FROM ubuntu:latest

WORKDIR /decoya/
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

COPY . ./app
COPY ./sshd_config.sh /usr/local/bin/sshd_config.sh

# permissions update
RUN mkdir -p /decoya/app/logs \
&& chmod -R 755 /decoya/app/logs \
&& chmod +x /decoya/app/*.sh \
&& chmod +x /decoya/app/read_users.py /decoya/app/create_user.py \
&& chmod +x /decoya/app/read_users.sh /decoya/app/create_user.sh \
&& chmod +x /usr/local/bin/sshd_config.sh \
&& mkdir -p /run/sshd \
&& chmod 0755 /run/sshd

# ssh config
RUN bash /usr/local/bin/sshd_config.sh

# Python environment 
RUN python3 -m venv ./env
RUN chmod +x ./env/bin/activate

SHELL ["/bin/bash", "-c"]
RUN source ./env/bin/activate
RUN ./env/bin/pip install --no-cache-dir \
mysql-connector-python

# Set root password for SSH access if none
RUN echo 'root:pass123' | chpasswd

CMD ["/usr/sbin/sshd", "-D"]
# CMD ["tail", "-f", "/dev/null"]
