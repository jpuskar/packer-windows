
IF NOT EXIST C:\windows\temp\kb3021910 MKDIR C:\windows\temp\kb3021910
powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/7/7/4/77476115-26DA-42FC-B00F-031D2BB3740F/Windows8.1-KB3021910-x64.msu', 'C:\Windows\Temp\Windows8.1-KB3021910-x64.msu'))"
wusa.exe C:\Windows\Temp\Windows8.1-KB3021910-x64.msu /extract:C:\Windows\Temp\KB3021910
dism.exe /online /add-package /PackagePath:C:\Windows\Temp\KB3021910\Windows8.1-KB3021910-x64.cab

IF NOT EXIST C:\windows\temp\kb3000850 MKDIR C:\windows\temp\kb3000850
wusa.exe E:\w63-x64\glb\Windows8.1-KB3000850-x64.msu /extract:C:\Windows\Temp\kb3000850
dism.exe /online /add-package /PackagePath:C:\Windows\Temp\kb3000850\Windows8.1-KB3000850-x64.cab /Quiet
rmdir /S /Q C:\Windows\Temp\kb3000850
rmdir /S /Q C:\windows\temp\kb3021910
del /f /q C:\Windows\Temp\Windows8.1-KB3021910-x64.msu

shutdown -t 5 -r -f
exit 0
