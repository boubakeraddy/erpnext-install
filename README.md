# ERPNext v15 Installer Script

This repository contains a **Bash script to install ERPNext version 15** in a production-ready setup on **Ubuntu 22.04**, using **Python 3.11**.

The script sets up:
- ERPNext v15 and Frappe framework
- Python 3.11 environment
- MariaDB, Redis, NGINX, and Supervisor
- Production deployment via `bench setup production`
- Optional: Placeholder for custom app installation

---

## ⚙️ Requirements

- A fresh Ubuntu 22.04 server
- Root or sudo privileges
- Domain name (optional, for Let's Encrypt)

---

## 🚀 Quick Install (One-Liner)

> 🛡️ **Warning:** This runs the script directly from GitHub using `sh`. Only use this from trusted sources.

Using `curl`:

```bash
curl -s https://raw.githubusercontent.com/yourusername/yourrepo/main/install_erpnext_v15.sh | sudo sh
