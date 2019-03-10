Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value null -Force
Get-Item WSMAN:\Localhost\Client\TrustedHosts
Stop-Service WinRM
Get-Service WinRM