MAC Address Change Detector is a Bash-based networking utility that monitors MAC address integrity at the network interface level.
The script allows explicit control over which interface is checked or enables bulk monitoring across all active interfaces (excluding loopback).

It captures the current MAC address using standard Linux networking tools, compares it against a previously stored value, and reports whether the MAC address has changed.
Each interface is tracked independently, making the script suitable for environments where multiple NICs or virtual interfaces exist.

This script reinforces core networking concepts such as:
- MAC address identity
- Interface-level state monitoring
- Command output parsing
- Change detection logic

USAGE MODES

./mac_detector.sh eth0 (Monitor a specific interface)
./mac_detector.sh -all (Monitor all non-loopback interfaces)
