### PL ###

Zmienne:

$date = Get-Date -UFormat "%d-%m-%Y"
$time = Get-Date -UFormat %T
$service = "t*"
$filename = $date + ".csv"

date - pobierze aktualną datę systemową. Dzięki parametrowi -UFormat można pobrać datę w wygodny dla nas sposób - w tym przypadku data będzie miała format: "Dzień-Miesiąc-Rok",
time - pobierze aktulny czas systemowy. Dzięki parametrowi -UFormat można pobrać czas w wygodny sposób - w tym przykładzie czas będzie podany w formacie: "Godzina:Minuta:Sekunda",
service - zmienna, która definiuje które serwisy będą nas interesować do stworzenia raportu - w tym przypadku będą to wszystkie serwisy zaczynające się na literę "t",
filename - definiuje nazwę raportu, który zostanie utworzony - w tym przypadku będzie to aktualna data z rozszerzeniem csv.

----

Tworzenie nagłówka w raporcie:

"Name,Status,$date,$time" >> $filename

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
		$line + ",Connection status:,Failed" >> $filename
	}
	
Pierwsze instrukcja warunkowa sprawdza czy połączenie do serwera się nie udało - jeżeli połączenie z serwerem nie zostało ustanowione to w pliku otrzymamy komunikat: Connection status: Failed.
	
elseif ($connectionResult -eq $True)
	{
		$serviceStatus = Get-Service $service -ComputerName $line
		"" >> $filename
		$line + ",Connection status:,OK" >> $filename
		$serviceStatus | select-object Name,Status | export-csv -path $filename -Append -Force
	}

Druga instrukcja warunkowa sprawdza czy połączenie do serwera się udało - jeżeli tak się stało to w pliku otrzymamy takie informacje jak nazwa i statusy serwisów zaczynających się na literę t (dzięki parametrowi select-object Name,Status otrzymamy tylko i wyłącznie nazwy i statusy serwisów zaczynających się na literę t). Komenda export-csv pozwala nam w łatwy sposób dodawać rekordy do już utworzonego pliku csv, parametr:
	Append - odpowiada za dodawanie wierszy z zawartością do istniejącego pliku, jeżeli nie wykorzystamy tego parametru to plik csv za każdym razem będzie nadpisywany,
	Force - pozwala nam na dodawanie rekordów nawet jeżeli nie mają zgodnej z nimi nazwy kolumny

	
!!! W trakcie otwierania pliku csv należy wybrać separator przecinek "," w innym wypadku plik nie będzie dobrze importował kolumn ani rekordów !!!