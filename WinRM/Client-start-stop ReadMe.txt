### PL ###

START
Zmienne:
$trustedIP = "192.168.0.178"
$credentials = "PcName\Login"
$auth = "Negotiate"

trustedIP - przyjmuje wartość IP serwera z którym będziemy się łączyć,
credentials - przyjmuje wartość nazwy serwera i loginu na ten serwer,
auth - określa rodzaj autentykacji podczas łączenia się z serwerem.

----

Start-Service WinRM - włącza serwis Windows Remote Management - jest on niezbędny do połączenia się z serwerem

Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value $trustedIP -force - modyfikuje plik zaufanych hostów i dodaje do niego IP serwera z którym będziemy się łączyć
Get-Item WSMAN:\Localhost\Client\TrustedHosts - pobiera zawartość pliku zaufanych hostów i pokazuje je w konsoli - ten krok można wykomentować w skrypcie natomaist jest to przydatne do sprawdzenia czy plik z zaufanymi hostami na pewno został zmodyfikowany

Get-Service WinRM - sprawdza czy serwis WinRM został uruchomiony - ta linjika może zostać wykomentowana

Test-WSMan $trustedIP -credential $credentials -Authentication $auth - sprawdza czy jest możliwe połączenie się ze zdalnym hostem poprzez WinRM ze zdefiniowanymi wcześniej credentialami - na obu komputerach (serwera i klienta) musi być uruchomiony WinRM aby test przeszedł pomyślnie

#Enter-PSSession $trustedIP -credential $credentials -Authentication $auth - po odkomentowaniu tej linjiki można połączyć się z serwerem i wykonywać komendy po stronie serwera

----

STOP

Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value null -Force - modyfikuje plik zaufanych hostów i usuwa z niego wszystkie IP - wykonujemy ten krok w celach bezpieczeństwa
Get-Item WSMAN:\Localhost\Client\TrustedHosts - pobiera zawartość pliku zaufanych hostów i pokazuje je w konsoli - ten krok można wykomentować w skrypcie natomaist jest to przydatne do sprawdzenia czy plik z zaufanymi hostami na pewno został zmodyfikowany

Stop-Service WinRM - wyłącza serwis Windows Remote Management - wykonujemy ten krok w celach bezpieczeństwa
Get-Service WinRM - sprawdza czy serwis WinRM został zatrzymany - ta linjika może zostać wykomentowana


!!! Powershell w przypadku tych skryptów musi zostać uruchomiony z prawami administratora !!!