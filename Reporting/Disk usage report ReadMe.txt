### PL ###

Zmienne:

$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$diskLetter = "C:"
$filename = $date + ".csv"


date - pobierze aktualną datę systemową. Dzięki parametrowi -UFormat można pobrać datę w wygodny dla nas sposób - w tym przypadku data będzie miała format: "Dzień-Miesiąc-Rok",
time - pobierze aktulny czas systemowy. Dzięki parametrowi -UFormat można pobrać czas w wygodny sposób - w tym przykładzie czas będzie podany w formacie: "Godzina:Minuta:Sekunda",
diskLetter - definiuje jaki dysk będzie sprawdzany - w tym przypadku będzie sprawdzany dysk C,
filename - definiuje nazwę raportu, który zostanie utworzony - w tym przypadku będzie to aktualna data z rozszerzeniem csv.

----

Tworzenie nagłówka w raporcie:

"$date,$time" >> $filename

Ta linijka pozwala na stworzenie wiersza z nazwami kolumn w pliku przy każdym uruchomieniu skryptu - dzięki temu otrzymamy kolumny: Name, Status, obecną datę oraz obecny czas.

----

Pobieranie adresów IP:

foreach($line in Get-Content ip.txt)

Ta pętla foreach będzie pobierała adresy IP z pliku tekstowego ip.txt i zapisywała je do zmiennej $line - plik ip.txt musi być przygotowany w taki sposób, aby każdy adres IP był w osobnej linii tekstu.

----

Sprawdzanie połączenia:

$connectionResult = Test-Connection -ComputerName $line -Count 5 -Quiet

Zmienna connectionResult będzie miała przypisany status połączenia do serwera (IP pobranego z kroku wcześniej).
Parametr:
	Count - odpowiada za ilość prób połączenia do serwera - w tym przypadku skrypt będzie próbował połączyć się z serwerem 5 razy,
	Quiet - dzięki temu parametrowi otrzymamy w wyniku testowania połączenia wartość boolean (true albo false) - w przypadku tego skryptu potrzebujemy tylko takich wartości wyjściowych.

----

Podejmowanie akcji na podstawie statusu połączenia:

if ($connectionResult -eq $False)
	{
		"" >> $filename
		$line + ";Connection status:;Failed" >> $filename
	}
	
Pierwsze instrukcja warunkowa sprawdza czy połączenie do serwera się nie udało - jeżeli połączenie z serwerem nie zostało ustanowione to w pliku otrzymamy komunikat: Connection status: Failed.
	
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

Druga instrukcja warunkowa sprawdza czy połączenie do serwera się udało - jeżeli tak się stało to w pliku otrzymamy takie informacje jak pojemność dysku, ilość wolnego miejsca na dysku oraz procent wolnego miejsca na dysku podaną w gigabajtach z dokładnością do 2 miejsc po przecinku.
	
!!! W trakcie otwierania pliku csv należy wybrać separator przecinek "," w innym wypadku plik nie będzie dobrze importował kolumn ani rekordów !!!