$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$diskLetter = "C:"
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
			$disk = Get-WmiObject win32_logicaldisk -ComputerName $line -Filter "DeviceID='$diskLetter'" | Select-Object FreeSpace,Size
			"" >> $filename
			$line + ",Connection status:,OK" >> $filename
			"Dysk:," + $diskLetter >> $filename
			"Pojemność dysku:," + [math]::Round($disk.Size/1GB,2) + ",GB" >> $filename
			"Wolne miejsce:," + [math]::Round($disk.FreeSpace/1GB,2) + ",GB" >> $filename
			"Procent wolnego:," + [math]::Round($disk.FreeSpace/$disk.Size*100,2) + ",%" >> $filename
		}
}
