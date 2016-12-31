#$job = Start-Job {
#    cmd.exe /c E:\update.cmd
#}
#Wait-Job -job $job -Timeout 30
#Receive-Job $job

$env:PACKER_LOG=1
$env:PACKER_LOG_PATH="packerlog.txt"

$break_count = 0
while($break_count -lt 3) {
    $logfile_contents = $null
    Write-Output "Attempting to query for C:\windows\wsusofflineupdate.log."
    Try {
        $logfile_contents = gc $env:systemroot\wsusofflineupdate.log | select -last 10
    } Catch {
    }

    if($logfile_contents -like "*Starting WSUS Offline Update*") {
        Write-Output "Wsusoffline just started."
        $break_count = 0
    } else {
        if($logfile_contents -like "*Ending WSUS Offline Update*") {
          Write-Output "Wsusoffline is ending."
          $break_count++
            #if($logfile_contents -like "*Registered deletion of recall directory*") {
            #
            #}
        }
    }

    Start-Sleep -Seconds 30
}

$logfile_contents = gc $env:systemroot\wsusofflineupdate.log | select -last 10
Write-Output "Last 10 lines of C:\windows\wsusofflineupdate.log:"
Write-Output $logfile_contents

#Enable winrm
#Enable-PSRemoting -Force
#winrm quickconfig -q
#winrm quickconfig -transport:http
#winrm set winrm/config '@{MaxTimeoutms="1800000"}'
#winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
#winrm set winrm/config/service '@{AllowUnencrypted="true"}'
#winrm set winrm/config/service/auth '@{Basic="true"}'
#winrm set winrm/config/client/auth '@{Basic="true"}'
#winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'
#netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
#netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow
#Set-Service winrm -startuptype "auto"
#Restart-Service winrm

## Needs to reconfigure auto-login for vagrant/vagrant also, because DoUpdate.cmd from wsusoffline
## Resets autologin and breaks packer.
#New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon -Value 1 -Force
#New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultUserName -Value "vagrant" -Force
#New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -Value "vagrant" -Force

## Needs to remove itself from startup folder.
#Remove-Item 'C:\programdata\Microsoft\Windows\Start Menu\Programs\StartUp\run-updates.cmd' -Force

## Needs to reboot
Restart-Computer -Force
