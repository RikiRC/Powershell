### PL ###

Zmienne:

$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$lType = "System"
$eType = "Error"
$ammount = 10
$filename = $date + ".csv"


date - pobierze aktualną datę systemową. Dzięki parametrowi -UFormat można pobrać datę w wygodny dla nas sposób - w tym przypadku data będzie miała format: "Dzień-Miesiąc-Rok",
time - pobierze aktulny czas systemowy. Dzięki parametrowi -UFormat można pobrać czas w wygodny sposób - w tym przykładzie czas będzie podany w formacie: "Godzina:Minuta:Sekunda",
lType - zmienna, która zdefiniuje z którego loga będziemy chcieli pobrać wpisy - w tym przypadku pobierane wpisy będą z loga System,
eType - zmienna, która zdefiniuje jaki rodzaj wpisów będzie pobierany z loga - w tym przypadku pobierane będą tylko Errory,
ammount - definiuje ile wpisów z loga będzie pobieranych - w tym przypadku tylko 10 wpisów,
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
		$getEvent = Get-EventLog $lType -EntryType $eType -Newest $ammount
		"" >> $filename
		$line + ";Connection status:;OK" >> $filename
		for($i=0; $i -lt $ammount; $i++)
			{
				$getEvent.TimeWritten.GetValue($i) >> $filename
				$getEvent.Message.GetValue($i) >> $filename
			}
	}

Druga instrukcja warunkowa sprawdza czy połączenie do serwera się udało - jeżeli tak się stało to w pliku otrzymamy takie informacje jak najnowsze 10 errorów z loga systemowego. Zmienna getEvent pobierze wszelkie informacje o najnowszych 10 błędach w logu systemowym natomiast wykorzystanie zmiennej getEvent.TimeWritten i getEvent.Message pozwoli zapisać w pliku daty i błędy.

	
!!! W trakcie otwierania pliku csv należy wybrać separator średnik ";" w innym wypadku plik nie będzie dobrze importował kolumn ani rekordów !!!