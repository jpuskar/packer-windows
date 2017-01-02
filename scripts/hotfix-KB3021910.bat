REM powershell -command "while($true){start-sleep -seconds 60}"

powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/7/7/4/77476115-26DA-42FC-B00F-031D2BB3740F/Windows8.1-KB3021910-x64.msu', 'C:\Windows\Temp\Windows8.1-KB3021910-x64.msu'))"

wusa.exe C:\Windows\Temp\Windows8.1-KB3021910-x64.msu /quiet /log:C:\KB3021910_log.etv

powershell -command "while($true){start-sleep -seconds 60}"
powershell -command "while($true){start-sleep -seconds 60}"
powershell -command "while($true){start-sleep -seconds 60}"
