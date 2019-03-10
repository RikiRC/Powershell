$login = get-content cred_user.txt
$pass = get-content cred_password.txt | convertto-securestring
$credentials = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $login,$pass
$auth = "Negotiate"

$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$service = "t*"
$filename = $date + ".csv"
"Name,Status,$date,$time" >> $filename

foreach($line in Get-Content ip.txt)
{
	$connectionResult = Test-Connection -ComputerName $line -Count 2 -Quiet
	if ($connectionResult -eq $False)
		{
			"" >> $filename
			$line + ",Connection status:,Failed" >> $filename
		}
		
	elseif ($connectionResult -eq $True)
		{
			$line + ",Connection status:,OK" >> $filename
			"" >> $filename
			Invoke-Command -ComputerName $line -Credential $credentials -Authentication $auth -ScriptBlock{
				$serviceStatus = Get-Service $Using:service
				$serviceStatus | select-object Name,Status
				} | export-csv -path $filename -Append -Force
		}
}