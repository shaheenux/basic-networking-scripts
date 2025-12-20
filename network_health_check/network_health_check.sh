#!/bin/bash
# File: scripts/basics/network_health_check.sh
# Purpose: Show system identity, interfaces, IPs, and ping a target IP
# Constraints: Bash, readable, no frameworks, no automation, no noise

# Check if an IP argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <target-ip>"
    exit 1
fi

TARGET_IP="$1"

echo "=== System Identity ==="
hostname
uname -a

echo ""
echo "=== Network Interfaces ==="
ip link show

echo ""
echo "=== IP Addresses ==="
ip addr show

echo ""
echo "=== Ping Target ==="
ping -c 4 "$TARGET_IP"
