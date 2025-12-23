# 🌐 Server MNC (Monitoring & Connectivity) Suite
**A robust, enterprise-ready Bash framework for network health and latency auditing.**

---

## 📖 Introduction
The **Server MNC Suite** is a lightweight yet powerful tool designed to give system administrators and security researchers total visibility over their network infrastructure. By utilizing asynchronous checks and modular configuration files, this suite provides real-time feedback and long-term data logging without the overhead of heavy monitoring software.

---

## 🛠️ Core Functionalities

### 1. Uptime Monitoring
Automatically iterates through your `servers.txt` file to verify host availability using ICMP echo requests. 
* **Reliability:** Uses a 2-second wait window to ensure accurate reporting even on high-latency links.
* **Logging:** Records every state change with a millisecond-precision timestamp.

### 2. Service & Port Auditing
Cross-references every server in your list against the protocols defined in `ports.txt`. 
* **Technique:** Utilizes the `/dev/tcp` stack for stealthy and rapid connection attempts.
* **Flexibility:** Easily audit web servers (80/443), databases (3306/5432), or management interfaces (22/3389).

### 3. Latency Analytics
Tracks network performance trends for specific targets in `ping_svr.txt`.
* **Data Format:** Outputs to a standard `.csv` (Comma Separated Values) format.
* **Analysis:** Perfect for importing into Excel, Grafana, or Python (Pandas) to visualize network jitter and lag spikes.

---

## 📂 System Architecture
The project follows a "Flat-Data" domestic structure to ensure portability across Linux distributions:

| File Name | Role | Description |
| :--- | :--- | :--- |
| `server_mnc.sh` | **Engine** | The primary logic executor. |
| `servers.txt` | **Targets** | Define your IP addresses here (one per line). |
| `ports.txt` | **Services** | Define the ports you want to scan. |
| `ping_svr.txt` | **Sensors** | Targets for detailed RTT (Round Trip Time) logs. |
| `logs/` | **Vault** | Automatically generated folder containing `uptime.log` and `latency.csv`. |

---

## 🚀 Installation & Deployment

### Step 1: Create Folder and Set Permissions
Create a directory for your monitoring suite and set executable permissions:
```bash
mkdir ~/NetworkMon && cd ~/NetworkMon
chmod +x server_mnc.sh
```

### Step 2: Populate Configuration Files
Edit your configuration files. You may use `#` to add comments within your server and port lists.

### Step 3: Manual Run
Execute the script to verify the configuration:
```bash
./server_mnc.sh
```

### Step 4: Automation (Cron Job)
To enable 24/7 monitoring on your system, use the Linux Cron utility:

1. Open the crontab editor:
```bash
crontab -e
```

2. Add the following line to run the monitor every 15 minutes (adjust path as needed):
```cron
*/15 * * * * /home/youruser/NetworkMon/server_mnc.sh
```

---

## 🎯 Kali Linux Compatibility & Setup
This script is **fully compatible with Kali Linux**. Since Kali is based on Debian, it uses the standard `bash` shell and includes `ping` and `timeout` utilities by default.

**Optional Optimization:** While not strictly required, running as `sudo` on Kali ensures `ping` has high-priority socket access for more accurate latency timing.

---

## 🛡️ Requirements & Compatibility
* **Tested OS:** Kali Linux, Ubuntu 22.04+, Debian, Arch Linux
* **Shell:** Bash v4.0 or higher
* **Dependencies:** `ping`, `grep`, `awk`, `timeout`

---

*Developed for efficiency. May your packets always find their way.*
