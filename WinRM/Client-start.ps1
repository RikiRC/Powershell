$trustedIP = "192.168.0.178"
$credentials = "PcName\Login"
$auth = "Negotiate"

Start-Service WinRM
Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value $trustedIP -force
Get-Item WSMAN:\Localhost\Client\TrustedHosts
Get-Service WinRM
Test-WSMan $trustedIP -credential $credentials -Authentication $auth
#Enter-PSSession $trustedIP -credential $credentials -Authentication $auth