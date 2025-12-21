# Network Health Check Script

This script performs a **basic network health check** on a Linux system.  
It is designed for beginners to understand how system identity and network status can be verified using simple Bash commands.

The script displays:
- System hostname and kernel information
- Available network interfaces
- Assigned IP addresses
- Connectivity status to a specified target IP using `ping`

## Learning Objectives
- Understanding system identity commands (`hostname`, `uname`)
- Viewing network interfaces with `ip link`
- Inspecting IP configuration using `ip addr`
- Testing basic network connectivity with `ping`
- Passing and validating command-line arguments in Bash

## Usage
```bash
./network_health_check.sh <target-ip>
