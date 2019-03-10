$trustedIP = "192.168.0.199"

Start-Service WinRM
Enable-PSRemoting
Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value $trustedIP
Get-Item WSMAN:\Localhost\Client\TrustedHosts 
Get-Service WinRM
