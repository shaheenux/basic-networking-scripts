🌐 Server MNC (Monitoring & Connectivity) Suite

A professional, lightweight Bash automation tool for real-time network health auditing.
🚀 Overview

The Server MNC Suite is designed for system administrators and developers who need a "no-fuss" monitoring solution. It automates the tedious task of checking server reachability, verifying open services (ports), and logging latency trends for analysis.
✨ Key Features

    Multi-Target Uptime: Monitor multiple servers simultaneously via servers.txt.

    Service Auditing: Cross-check every server against a custom list of critical ports.

    Latency Analytics: High-precision RTT tracking logged directly into a .csv format.

    Auto-Logging: Maintains a historical record of network events in a dedicated /logs directory.

    Smart Timeouts: Built-in 2-second timeout to prevent script hangs on dead IPs.

📂 Project Architecture

The suite uses a modular "Domestic Structure" to keep your configuration separate from the logic:
Bash

.
├── server_mnc.sh      # 🧠 The Brain: Core logic and execution
├── servers.txt        # 🖥️ Targets: List of Server IPs/Hostnames
├── ports.txt          # 🔌 Services: List of Ports to audit (80, 443, etc.)
├── ping_svr.txt       # 📈 Analytics: IPs for latency tracking
├── user_guide.txt     # 📖 Manual: Detailed user instructions
└── logs/              # 📊 History: Auto-generated log files
    ├── uptime.log     # Records ON/OFF status
    └── latency.csv    # Spreadsheet-ready RTT data

🛠️ Installation & Usage
1. Clone & Prepare

Place all files in your desired directory and grant execution permissions:
Bash

chmod +x server_mnc.sh

2. Configure

Update your .txt files with your network infrastructure data.

    Tip: You can use comments in your text files by starting a line with #.

3. Execute

Run the suite manually:
Bash

./server_mnc.sh

📊 Sample Output

Terminal View:
Plaintext

[*] Checking Server Uptime...
 [+] 192.168.1.1 is UP
 [-] 10.0.0.5 is DOWN

[*] Checking Port Availability...
 [OPEN] 192.168.1.1:80
 [CLOSED] 192.168.1.1:22

Latency CSV Format: | Timestamp | Target_IP | RTT_ms | | :--- | :--- | :--- | | 2025-12-23 23:05 | 8.8.8.8 | 14.2 | | 2025-12-23 23:05 | 1.1.1.1 | 8.5 |
⏰ Automation (Cron)

Keep your logs up to date by running the script every 10 minutes. Add this to your crontab -e:
Code snippet

*/10 * * * * /path/to/your/folder/server_mnc.sh

🛡️ Requirements

    OS: Linux / BSD / macOS

    Dependencies: bash, ping, awk

    Permissions: User must have write access to the directory for logging.
