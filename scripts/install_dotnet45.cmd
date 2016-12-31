start /wait powershell.exe -command "Install-WindowsFeature NET-Framework-45-Features, NET-Framework-45-Core"
rem shutdown -t 0 -r -f
rem net stop winrm
