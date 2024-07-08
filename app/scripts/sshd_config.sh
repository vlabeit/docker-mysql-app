#!/bin/bash

SSHD_CONFIG="/etc/ssh/sshd_config"

## Adding PermitRootLogin & PasswordAuthentication yes to sshd config to allow root access ##
echo "ssh config started"

# Replace or add PermitRootLogin yes
if grep -q "^PermitRootLogin" $SSHD_CONFIG; then
    sed -i "s/^PermitRootLogin.*/PermitRootLogin yes/" $SSHD_CONFIG
    echo "PermitRootLogin updated"
else
    echo "PermitRootLogin yes" >> $SSHD_CONFIG
    echo "PermitRootLogin added"
fi

# Replace or add PasswordAuthentication yes
if grep -q "^PasswordAuthentication" $SSHD_CONFIG; then
    sed -i "s/^PasswordAuthentication.*/PasswordAuthentication yes/" $SSHD_CONFIG
    echo "PasswordAuthentication updated"
else
    echo "PasswordAuthentication yes" >> $SSHD_CONFIG
    echo "PasswordAuthentication added"
fi

# Reload SSH service to apply changes
service ssh reload
