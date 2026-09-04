# Created in 2026/09
#
# This script can be used to change Windows registry values to
# enable darkmode even if the Windows installation isn't activated.
#
# Tested on: 
# 
# PS> Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber
#
# Caption                  Version    BuildNumber
# -------                  -------    -----------
# Microsoft Windows 11 Pro 10.0.26200 26200
#
# To allow running scripts in Powershell run the following command:
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Then run the script: .\toggle_darkmode.ps1

$ThemePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

# Set Dark Mode (0)
Set-ItemProperty -Path $ThemePath -Name "AppsUseLightTheme" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $ThemePath -Name "SystemUsesLightTheme" -Value 0 -Type DWord -Force

# Apply changes by restarting Explorer
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Start-Process explorer.exe

Write-Host "Dark mode enabled." -ForegroundColor Green   
