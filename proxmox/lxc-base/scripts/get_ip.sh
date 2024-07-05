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

CONTAINER_IP=$(ssh root@$PROXMOX_HOST "pct exec $CONTAINER_ID -- ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'")

# Check if the IP was retrieved successfully
if [ -z "$CONTAINER_IP" ]; then
    echo "Failed to retrieve container IP" >&2
    exit 1
fi

echo "{\"container_ip\": \"$CONTAINER_IP\"}"
