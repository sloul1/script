$ThemePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

# Set Dark Mode (0)
Set-ItemProperty -Path $ThemePath -Name "AppsUseLightTheme" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $ThemePath -Name "SystemUsesLightTheme" -Value 0 -Type DWord -Force

# Apply changes by restarting Explorer
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Start-Process explorer.exe

Write-Host "Dark mode enabled." -ForegroundColor Green   