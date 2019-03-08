$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$lType = "System"
$eType = "Error"
$ammount = 10
$filename = $date + ".csv"
"$date,$time" >> $filename

foreach($line in Get-Content ip.txt)
{
	$connectionResult = Test-Connection -ComputerName $line -Count 5 -Quiet
	if ($connectionResult -eq $False)
		{
			"" >> $filename
			$line + ";Connection status:;Failed" >> $filename
		}
		
	elseif ($connectionResult -eq $True)
		{
			$getEvent = Get-EventLog $lType -EntryType $eType -Newest $ammount
			"" >> $filename
			$line + ";Connection status:;OK" >> $filename
			for($i=0; $i -lt $ammount; $i++)
				{
					$getEvent.TimeWritten.GetValue($i) >> $filename
					$getEvent.Message.GetValue($i) >> $filename
				}
		}
}

