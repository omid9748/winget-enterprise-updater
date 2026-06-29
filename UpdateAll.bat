@echo off
:: فعال‌سازی کدگذاری UTF-8 برای نمایش درست آیکون‌ها
chcp 65001 >nul

:: ۱. درخواست خودکار دسترسی ادمین (UAC)
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: پارامترهای اصلی شبکه و لاگ
set "PROXY_IP=10.10.1.119"
set "PROXY_PORT=10809"
set "LOG_FILE=%~dp0winget_upgrade_report.log"

title Winget Enterprise Automated Updater
cls

echo ==================================================
echo      ⚡ WINGET ENTERPRISE AUTOMATED UPDATER ⚡
echo      Developer: Omid Mohammadzadeh
echo ==================================================
echo.

:: ۲. بررسی هوشمند در دسترس بودن پروکسی سرور
echo [*] Testing connectivity to proxy server (%PROXY_IP%)...
ping -n 1 %PROXY_IP% | find "TTL=" >nul
if %errorLevel% neq 0 (
    echo [X] Error: Proxy server %PROXY_IP% is unreachable!
    echo [*] Aborting pipeline to prevent network timeout.
    echo.
    pause
    exit /b
)

:: ۳. تنظیم پروکسی برای عبور از محدودیت‌ها
netsh winhttp set proxy %PROXY_IP%:%PROXY_PORT% >nul
set HTTP_PROXY=http://%PROXY_IP%:%PROXY_PORT%
set HTTPS_PROXY=http://%PROXY_IP%:%PROXY_PORT%

echo [✔] Secure connection established with gateway.

:: ۴. بررسی و نصب هوشمند Winget در صورت عدم وجود (مخصوص ویندوز سرور)
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [!] Winget engine is missing on this machine!
    echo [*] Initiating background environment deployment via Microsoft GitHub...
    
    :: اجرای دستور پاوِرشِل به صورت سایلنت در پس‌زمینه برای دانلود و نصب پیش‌نیازها و باندل اصلی
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "$dir = \"$env:TEMP\WingetInst\"; if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir >$null }; " ^
        "Write-Host '[*] Downloading UI Xaml and VCLibs dependencies...' -ForegroundColor Gray; " ^
        "Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx' -OutFile \"$dir\UiXaml.appx\" -UseBasicParsing; " ^
        "Invoke-WebRequest -Uri 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile \"$dir\VCLibs.appx\" -UseBasicParsing; " ^
        "Add-AppxPackage -Path \"$dir\VCLibs.appx\"; Add-AppxPackage -Path \"$dir\UiXaml.appx\"; " ^
        "Write-Host '[*] Fetching latest Winget binaries from official repository...' -ForegroundColor Gray; " ^
        "Invoke-WebRequest -Uri 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' -OutFile \"$dir\WingetCore.msixbundle\" -UseBasicParsing; " ^
        "Invoke-WebRequest -Uri 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml' -OutFile \"$dir\WingetLicense.xml\" -UseBasicParsing; " ^
        "Add-AppxPackage -Path \"$dir\WingetCore.msixbundle\" -LicensePath \"$dir\WingetLicense.xml\"; " ^
        "Remove-Item -Path $dir -Recurse -Force >$null"
        
    echo [✔] Winget environment deployed successfully!
    echo.
)

echo [*] Fetching available updates from Winget, please wait...
echo.

:: ۵. استخراج و نمایش لیست پکیج‌های دارای آپدیت
winget upgrade --include-unknown
echo ==================================================

:: بررسی پارامتر اجرای خودکار (/silent)
if "%~1"=="/silent" (
    set "userinput=y"
    echo [*] Silent mode detected. Proceeding automatically...
) else (
    set /p userinput="Do you want to upgrade all listed packages? (y/N): "
)

if /i "%userinput%"=="y" (
    echo.
    echo [*] Initializing batch upgrade pipeline. Please stand by...
    echo.
    
    :: ساخت فایل لاگ و ثبت تاریخ عملیات
    echo ========================================== >> "%LOG_FILE%"
    echo  EXECUTION DATE: %date% %time% >> "%LOG_FILE%"
    echo ========================================== >> "%LOG_FILE%"
    
    :: اجرای آپدیت فله‌ای پکیج‌ها
    winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements
    
    echo.
    echo [✔] Task execution finished. Log saved to: winget_upgrade_report.log
) else (
    echo.
    echo [X] Upgrade canceled by operator.
)

:: ۶. ریست کردن حتمی پروکسی برای جلوگیری از قطع اینترنت
netsh winhttp reset proxy >nul
echo.
echo ==================================================
echo [✔] System proxy network rollback completed safely.
echo ==================================================
pause