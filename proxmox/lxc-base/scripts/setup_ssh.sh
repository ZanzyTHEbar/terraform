#!/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <container_id> <proxmox_host>"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Usage: $0 <container_id> <proxmox_host>"
    exit 1
fi

# Extract the numeric container ID from the resource ID (format: node/lxc/id)
CONTAINER_ID=$(echo $1 | awk -F'/' '{print $3}')
PROXMOX_HOST=$2

function check_container_ready {
    ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa root@$PROXMOX_HOST "lxc-attach --name $CONTAINER_ID -- ping -c 1 google.com"
}

# Retry loop to wait until the container is ready
RETRY_COUNT=0
MAX_RETRIES=10
SLEEP_INTERVAL=10

while ! check_container_ready; do
    RETRY_COUNT=$((RETRY_COUNT + 1))
    if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
        echo "Container is not ready after $MAX_RETRIES attempts"
        exit 1
    fi
    echo "Waiting for container to be ready... ($RETRY_COUNT/$MAX_RETRIES)"
    sleep $SLEEP_INTERVAL
done

#chown -R root:root /root/.ssh
#chmod 700 /root/.ssh
#chmod 600 /root/.ssh/authorized_keys

# Modify sshd_config, ensure SSH server is running, enable firewall and allow SSH traffic
MOD_SSH=$(
    ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa root@$PROXMOX_HOST <<EOF
lxc-attach --name $CONTAINER_ID -- bash -c '
apt update && apt upgrade -y

sed -i.bak "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
sed -i.bak "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" /etc/ssh/sshd_config

if ufw status | grep -q "Status: active"; then
    echo "Firewall is enabled"
else
    echo "Firewall is now enabled"
    ufw --force enable
fi

if ufw status | grep -q "22/tcp"; then
    echo "SSH traffic is allowed"
else
    ufw allow ssh
    echo "SSH traffic is now allowed"
fi

if systemctl is-active --quiet ssh; then
    echo "SSH server is running"
    service ssh restart
else
    echo "SSH server is not running"

    if [ ! -d /run/sshd ]; then
        mkdir -p /run/sshd
    fi

    service ssh start
    echo "SSH server started"
fi
'
EOF
)

echo "{\"msg\": \"SSH server setup completed\", \"mod_ssh\": \"$MOD_SSH\"}"