#!/bin/bash

# File: server_mnc.sh
# Description: Network Monitoring and Connectivity Suite

# Configuration Paths
SERVER_FILE="servers.txt"
PORT_FILE="ports.txt"
PING_FILE="ping_svr.txt"
LOG_DIR="logs"
UPTIME_LOG="$LOG_DIR/uptime.log"
LATENCY_LOG="$LOG_DIR/latency.csv"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Initialize CSV header if latency log is new
if [ ! -f "$LATENCY_LOG" ]; then
    echo "Timestamp,Target_IP,RTT_ms" > "$LATENCY_LOG"
fi

echo "--- Starting Network Scan: $(date) ---"

# 1. Uptime Check (servers.txt)
echo "[*] Checking Server Uptime..."
while IFS= read -r ip || [ -n "$ip" ]; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    if ping -c 1 -W 2 "$ip" > /dev/null 2>&1; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $ip - ONLINE" >> "$UPTIME_LOG"
        echo " [+] $ip is UP"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $ip - OFFLINE" >> "$UPTIME_LOG"
        echo " [-] $ip is DOWN"
    fi
done < "$SERVER_FILE"

# 2. Port Availability (servers.txt + ports.txt)
echo -e "\n[*] Checking Port Availability..."
while IFS= read -r ip || [ -n "$ip" ]; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    while IFS= read -r port || [ -n "$port" ]; do
        [[ -z "$port" || "$port" =~ ^# ]] && continue
        # Use timeout and bash tcp for fast checking
        (echo > /dev/tcp/"$ip"/"$port") >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo " [OPEN] $ip:$port"
        else
            echo " [CLOSED] $ip:$port"
        fi
    done < "$PORT_FILE"
done < "$SERVER_FILE"

# 3. Latency Tracker (ping_svr.txt)
echo -e "\n[*] Logging Latency..."
while IFS= read -r ip || [ -n "$ip" ]; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    # Extract RTT using awk
    rtt=$(ping -c 1 "$ip" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1)
    if [ -z "$rtt" ]; then rtt="TIMEOUT"; fi
    
    echo "$(date '+%Y-%m-%d %H:%M:%S'),$ip,$rtt" >> "$LATENCY_LOG"
    echo " [LATENCY] $ip: ${rtt}ms"
done < "$PING_FILE"

echo -e "\n--- Scan Complete. Logs updated in /$LOG_DIR ---"