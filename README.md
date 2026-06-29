# ⚡ Winget Enterprise Automated Updater

A smart, lightweight, and fully automated single-click solution for upgrading Windows packages through enterprise proxies and corporate networks.

اسکریپت هوشمند، سبک و تک‌کلیک جهت به‌روزرسانی خودکار نرم‌افزارهای ویندوز در محیط‌های سازمانی، اتاق سرور و شبکه‌های تحت پروکسی.

---

## 🌍 Language / زبان
- [English (#-english)](#-english)
- [فارسی (#-فارسی)](#-فارسی)

---

## 🇺🇸 English

### 📝 Description
In many enterprise environments, production servers and corporate client machines do not have direct access to the Internet and must route traffic through a local proxy. **Winget Enterprise Automated Updater** is a single-file Batch script (`.bat`) designed for network administrators and DevOps engineers to seamlessly audit, fetch, and deploy Windows software updates via Microsoft Winget, bypassing network restrictions and sanctions automatically.

### ✨ Key Features
* **Zero-Configuration Deployment:** No prior PowerShell execution policy tweaks or environment setups required.
* **Smart UAC Self-Elevation:** Automatically requests Administrator privileges or prompts for admin credentials if executed by a standard user.
* **Auto-Winget Provisioning:** Detects if the Winget engine is missing (highly common on **Windows Server** versions) and automatically deploys the core package along with its UI Xaml and VCLibs dependencies from Microsoft's official repository in the background.
* **Gateway Health-Check:** Pings the proxy server to verify active connectivity before tweaking internet configurations, preventing network timeouts.
* **Dynamic Network Rollback:** Guarantees a safe rollback of HTTP/HTTPS winhttp proxies once operations finish or if a critical pipeline exception occurs.
* **Automated Auditing & Logging:** Generates execution histories (`winget_upgrade_report.log`) next to the script for enterprise infrastructure logging.
* **Silent Mode Trigger:** Supports a `/silent` flag for seamless automation via **Windows Task Scheduler**.

### 💻 Supported Operating Systems
This script is fully compatible with both Client and Enterprise Core architectures:
* **Windows Server:** 2016 / 2019 / 2022 / 2025 (Standard, Datacenter, and Core editions)
* **Windows Client:** Windows 10 / Windows 11 (Pro, Enterprise, and Education)

### ⚙️ How to Configure the Proxy
Before running the script, open the `.bat` file with any text editor and update the gateway parameters with your corporate proxy setup:
```cmd
set "PROXY_IP=10.10.1.119"   :: Replace with your Proxy Server IP
set "PROXY_PORT=10809"       :: Replace with your Proxy Port
