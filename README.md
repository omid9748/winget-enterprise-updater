# ⚡ Winget Enterprise Automated Updater

A smart, lightweight, and fully automated single-click solution for upgrading Windows packages through enterprise proxies and corporate networks.

اسکریپت هوشمند، سبک و تک‌کلیک جهت به‌روزرسانی خودکار نرم‌افزارهای ویندوز در محیط‌های سازمانی، اتاق سرور و شبکه‌های تحت پروکسی.

---

## 🌍 Language / زبان
- [English](#english)
- [فارسی](#فارسی)

---

## English

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
```

## فارسی
📝 توصیف پروژه
در بسیاری از سازمان‌ها و اتاق‌های سرور (Data Centers)، سرورهای تولیدی و کلاینت‌ها دسترسی مستقیم به اینترنت ندارند و مجبورند از یک پروکسی محلی عبور کنند. افزون بر این، محدودیت‌ها و تحریم‌های بین‌المللی مانع آپدیت مستقیم نرم‌افزارها می‌شوند. این اسکریپت تک‌فایلی Batch (.bat) به لایه زیرساخت و مدیران شبکه کمک می‌کند تا تنها با یک کلیک، فرآیند بررسی و به‌روزرسانی نرم‌افزارها را از طریق ابزار رسمی مایکروسافت (Winget) زیر سایه پروکسی به صورت کاملاً امن و خودکار جلو ببرند.

✨ ویژگی‌های برجسته
اجرای تک‌کلیک بدون نیاز به ساخت فایل پاوِرشِل: برطرف کردن چالش‌های مسدودی خط‌مشی امنیت اجرا (ExecutionPolicy) در ویندوز سرور.

ارتقای خودکار سطح دسترسی (Self-Elevation): درخواست هوشمند دسترسی ادمین (UAC)؛ در صورتی که کاربر عادی اسکریپت را اجرا کند، کادر استاندارد ویندوز برای ورود نام کاربری و رمز عبور ادمین شبکه ظاهر می‌شود.

استقرار خودکار و هوشمند Winget: اسکریپت بررسی می‌کند که آیا ابزار winget روی سیستم نصب است یا خیر (این ابزار به صورت پیش‌فرض روی ویندوز سرورها نصب نیست). در صورت عدم وجود، پیش‌نیازهای ساختاری دات‌نت (VCLibs و UI Xaml) و پکیج اصلی را کاملاً در پس‌زمینه و سایلنت از گیت‌هاب رسمی مایکروسافت دانلود و مستقر می‌کند.

تست زنده پیش از اتصال (Gateway Ping Check): پیش از دستکاری تنظیمات شبکه، ابتدا آی‌پي پروکسی را پینگ می‌کند تا در صورت خاموش بودن سرور واسط، اینترنت سیستم قفل نشود.

بازگردانی حتمی تنظیمات شبکه (Rollback): تضمین ۱۰۰ درصدی ریست شدن و پاک‌سازی پروکسی سیستم (winhttp) پس از اتمام کار یا در صورت بروز هرگونه خطا.

گزارش‌گیری سازمانی (Logging): ثبت تاریخچه و وضعیت پکیج‌های آپدیت شده در فایل خروجی winget_upgrade_report.log جهت مانیتورینگ ادمین‌ها.

پشتیبانی از حالت سایلنت: قابلیت ست شدن در Task Scheduler ویندوز با آرگومان /silent جهت آپدیت خودکار دوره‌ای (مثلاً ساعت ۳ بامداد).

💻 سیستم‌عامل‌های تحت پشتیبانی
این ابزار به طور کامل روی نسخه‌های کلاینت و سرور تست شده و پایدار است:

ویندوز سرور: نسخه‌های 2016 / 2019 / 2022 / 2025 (ویرایش‌های Standard، Datacenter و Core)

ویندوز کلاینت: ویندوز 10 و ویندوز 11 (ویرایش‌های Pro، Enterprise و Education)

⚙️ راهنمای تنظیمات پروکسی
قبل از اولین اجرا، فایل .bat را با یک ادیتور (مثل Notepad) باز کنید و آدرس پروکسی داخلی شبکه خود را در خطوط زیر جایگزین نمایید:

```cmd
set "PROXY_IP=10.10.1.119"   :: آی‌پی سرور پروکسی شما
set "PROXY_PORT=10809"       :: پورت پروکسی شما
```
🚀 نحوه استفاده
فایل UpdateAll.bat را روی دسکتاپ سیستم یا سرور قرار دهید.

روی آن دبل‌کلیک کنید.

اسکریپت پس از ست کردن پروکسی، لیست آپدیت‌های موجود را به شما نشان می‌دهد؛ کلید y را برای شروع ارتقای فله‌ای وارد کنید یا بگذارید به صورت زمان‌بندی شده کارش را انجام دهد.

Developer: Omid Mohammadzadeh

License: MIT


با جایگزینی این کد، ساختار لینک‌ها اصلاح شده و کاربر با کلیک روی هر زبان، مستقیماً به بخش مربوطه اسکرول خواهد شد. خسته نباشید، پروژه فوق‌العاده‌ای شد!
