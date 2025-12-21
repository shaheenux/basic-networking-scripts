#!/bin/bash

STORE_DIR="mac_store"
LOG_FILE="mac_change.log"

mkdir -p "$STORE_DIR"

scan_interface() {
    IFACE="$1"
    STORE_FILE="$STORE_DIR/$IFACE.mac"

    CURRENT_MAC=$(ip link show "$IFACE" | awk '/link\/ether/ {print $2}')

    if [ -z "$CURRENT_MAC" ]; then
        echo "Interface $IFACE not found or has no MAC"
        return
    fi

    if [ ! -f "$STORE_FILE" ]; then
        echo "$CURRENT_MAC" > "$STORE_FILE"
        echo "$IFACE : initial MAC stored ($CURRENT_MAC)"
        return
    fi

    STORED_MAC=$(cat "$STORE_FILE")

    if [ "$CURRENT_MAC" = "$STORED_MAC" ]; then
        echo "$IFACE : MAC unchanged"
    else
        echo "$IFACE : MAC changed"
        echo "Old: $STORED_MAC"
        echo "New: $CURRENT_MAC"
        echo "$(date) | $IFACE | OLD: $STORED_MAC | NEW: $CURRENT_MAC" >> "$LOG_FILE"
        echo "$CURRENT_MAC" > "$STORE_FILE"
    fi
}

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./mac_detector.sh eth0"
    echo "./mac_detector.sh -all"
    exit 1
fi

if [ "$1" = "-all" ]; then
    for IFACE in $(ip -o link show | awk -F': ' '$2!="lo" {print $2}'); do
        scan_interface "$IFACE"
    done
else
    scan_interface "$1"
fi
