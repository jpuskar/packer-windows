start E:\update.cmd
start /wait powershell -command "A:\Install-OfflineUpdates.ps1"
shutdown -t 0 -r -f
