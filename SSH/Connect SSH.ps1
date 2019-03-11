#Install-Module Posh-SSH

Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy ByPass

Import-Module Posh-SSH

$CurrentSession = New-SSHSession -ComputerName 192.168.0.101 -Credential login
$result = Invoke-SSHCommand -SSHSession $CurrentSession -Command "ls"
$result.Output

Set-ExecutionPolicy -ExecutionPolicy Restricted
