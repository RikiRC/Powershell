#Install-Module Posh-SSH - pozwala na zainstalowanie cmdletu Posh-SSH, który w tym przypadku jest niezbędny do prawidłowego działania skryptu - wystarczy go zainstalować raz a następnie można wykomentować ten krok

Get-ExecutionPolicy - sprawdzamy jaki jest execution policy naszego klienta
Set-ExecutionPolicy -ExecutionPolicy ByPass - ustawiamy execution policy na czas trwania skryptu w tryb ByPass (więcej pod https:/go.microsoft.com/fwlink/?LinkID=135170)

Import-Module Posh-SSH - importujemy moduł Posh-SSH dla działania skryptu

$CurrentSession = New-SSHSession -ComputerName 192.168.0.101 -Credential login - tworzymy nową sesję ssh z podaniem IP serwerea (192.168.0.101) i loginem do serwera (login)
$result = Invoke-SSHCommand -SSHSession $CurrentSession -Command "ls" - wykonujemy komendę "ls" po stronie serwera unixowego
$result.Output - dostajemy output z komendy "ls" po stronie windowsowskiego klienta

Set-ExecutionPolicy -ExecutionPolicy Restricted - ustawiamy spowrotem execution policy na taki jaki był przed ByPass - w tym przypadku jest to Restricted