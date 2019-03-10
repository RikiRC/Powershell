Disable-PSRemoting
winrm delete winrm/config/listener?Address=*+Transport=HTTP
winrm delete winrm/config/listener?Address=*+Transport=HTTPS
winrm e winrm/config/listener
Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value null
Get-Item WSMAN:\Localhost\Client\TrustedHosts 
Stop-Service WinRM
Get-Service WinRM
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name LocalAccountTokenFilterPolicy -Value 0
Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System | Select-Object LocalAccountTokenFilterPolicy