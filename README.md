# Windows Live IR Collector

A lightweight Windows batch script for **Live Incident Response (IR)** and **DFIR investigations**.  
This tool collects volatile system information quickly using native Windows CLI commands and saves the output into a structured case folder.

Designed for SOC analysts, DFIR responders, and cybersecurity students performing live system triage.

---

## 🎯 Purpose

During a live incident, volatile data can be lost quickly.  
This script helps responders rapidly collect key system artifacts such as:

- Running processes
- Loaded modules
- Service mappings
- Network connections
- ARP cache
- DNS cache
- Routing table
- User information
- Network shares
- Environment variables
- Workstation configuration
- Full system information

All results are written to a timestamped report file.

---

## 📂 Folder Structure Created

The script automatically creates:

Desktop\Cases\Case01-PolicyViolation\


All collected evidence output is stored inside this directory.

---

## 📄 Output File

Example output file:

liveIR-20260208-1530.txt


Includes:
- Date & time stamp
- Command results grouped by category
- Single consolidated forensic snapshot

---

## ▶️ Usage

### 1️⃣ Download or Clone

git clone https://github.com/<your-username>/live-ir-windows.git


Or download the `.bat` file directly.

---

### 2️⃣ Run

Right-click:

live_ir_collect.bat → Run as Administrator


Admin privileges are recommended to ensure full command output.

---

## 🧪 Commands Collected

The script runs:

tasklist
tasklist /m
tasklist /svc
netstat -nao
arp -a
ipconfig /all
ipconfig /displaydns
route print
set
net user
net share
net config workstation
systeminfo


All output is redirected into a single IR report file.

---

## ⚠️ Forensic Notes

- This script is intended for **live response triage**
- Uses native Windows commands only
- No external binaries required
- Minimal footprint
- Does not modify system configuration
- Still — always follow proper **chain of custody** procedures in real investigations

---

## 👨‍💻 Recommended Use Cases

- SOC live host triage
- Incident response labs
- DFIR training
- Malware investigation practice
- Cybersecurity student exercises

---

## 🔒 Limitations

- Not a full forensic acquisition tool
- Does not capture memory
- Does not create disk images
- Should be used alongside professional DFIR tools when available

---

## 🚀 Future Improvements (Planned)

- PowerShell advanced collector version
- Memory artifact collection
- Event log export
- Autoruns collection
- Scheduled tasks export
- Hash collection
- Browser artifact snapshot

---

## 📜 License

MIT License — Free for educational and professional use.

---

## 🤝 Contributions

Pull requests are welcome.  
DFIR and SOC improvements are encouraged.

---

## ⭐ Author

Created for DFIR & SOC practical investigations.
