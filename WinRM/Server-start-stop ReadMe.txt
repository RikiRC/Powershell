### PL ###

START

Zmienne:
$trustedIP = "192.168.0.199"

trustedIP - przyjmuje wartość IP klient któy będzie się łączył z tym komputerem

----

Start-Service WinRM - włącza serwis Windows Remote Management - jest on niezbędny aby klient mógł połączyć się z serwerem na którym uruchamiany jest ten skrypt
Enable-PSRemoting - włącza Powershell Remoting - dzięki temu klient połączony z tym serwerem będzie mógł na nim wykonywać skrypty i komendy z powershella

Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value $trustedIP -force - modyfikuje plik zaufanych hostów i dodaje do niego IP klienta który będzie się łączyć do tego serwera
Get-Item WSMAN:\Localhost\Client\TrustedHosts - pobiera zawartość pliku zaufanych hostów i pokazuje je w konsoli - ten krok można wykomentować w skrypcie natomaist jest to przydatne do sprawdzenia czy plik z zaufanymi hostami na pewno został zmodyfikowany

Get-Service WinRM - sprawdza czy serwis WinRM został uruchomiony - ta linjika może zostać wykomentowana

----

STOP

Disable-PSRemoting - wyłącza Powershell Remoting - wyłączamy w celach bezpieczeństwa

winrm delete winrm/config/listener?Address=*+Transport=HTTP
winrm delete winrm/config/listener?Address=*+Transport=HTTPS

Dwie powyższe linijki usuwają listenery, które nasłuchują komend z WinRM - usuwamy je w celach bezpieczeństwa

winrm e winrm/config/listener - sprawdza czy listenery na pewno zostały usunięte - brak wyniku oznacza, że nie ma już więcej listenerów

Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value null -Force - modyfikuje plik zaufanych hostów i usuwa z niego wszystkie IP - wykonujemy ten krok w celach bezpieczeństwa
Get-Item WSMAN:\Localhost\Client\TrustedHosts - pobiera zawartość pliku zaufanych hostów i pokazuje je w konsoli - ten krok można wykomentować w skrypcie natomaist jest to przydatne do sprawdzenia czy plik z zaufanymi hostami na pewno został zmodyfikowany

Stop-Service WinRM - wyłącza serwis Windows Remote Management - wykonujemy ten krok w celach bezpieczeństwa
Get-Service WinRM - sprawdza czy serwis WinRM został zatrzymany - ta linjika może zostać wykomentowana

Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name LocalAccountTokenFilterPolicy -Value 0 - modyfikuje wpis w rejestrze, który utrudni zdalne korzystanie z kont administratorskich na serwerze - wykonujemy to w celach bezpieczeństwa
Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System | Select-Object LocalAccountTokenFilterPolicy - sprawdza czy powyższy wpis w rejestrze został zmodyfikowany


!!! Powershell w przypadku tych skryptów musi zostać uruchomiony z prawami administratora !!!