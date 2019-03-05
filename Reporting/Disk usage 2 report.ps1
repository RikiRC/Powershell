$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$diskLetter = "CD"
$filename = $date + ".csv"
"$date,$time" >> $filename

foreach($line in Get-Content ip.txt)
{
	$connectionResult = Test-Connection -ComputerName $line -Count 5 -Quiet
	if ($connectionResult -eq $False)
		{
			"" >> $filename
			$line + ",Connection status:,Failed" >> $filename
		}
		
	elseif ($connectionResult -eq $True)
		{
			$disk = Get-Volume -DriveLetter $diskLetter
			"" >> $filename
			$line + ",Connection status:,OK" >> $filename
			$disk | Format-List DriveLetter,OperationalStatus,@{N='Free Space [GB],';E={[math]::Round($_.SizeRemaining/1GB,2)}},@{N='Size [GB],';E={[math]::Round($_.Size/1GB,2)}} >> $filename
		}
}
