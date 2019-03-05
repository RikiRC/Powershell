$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$service = "t*"
$filename = $date + ".csv"
"Name,Status,$date,$time" >> $filename

foreach($line in Get-Content ip.txt)
{
	if($line -match $regex)
	{	
		$connectionResult = Test-Connection -ComputerName $line -Count 5 -Quiet
		if ($connectionResult -eq $False)
			{
				"" >> $filename
				$line + ",Connection status:,Failed" >> $filename
			}
			
		elseif ($connectionResult -eq $True)
			{
				$serviceStatus = Get-Service $service -ComputerName $line
				"" >> $filename
				$line + ",Connection status:,OK" >> $filename
				$serviceStatus | select-object Name,Status | export-csv -path $filename -Append -Force
			}
	}
}
