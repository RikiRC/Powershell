### PL ###

Zmienne:
$user = get-content cred_user.txt
$pass = get-content cred_password.txt | convertto-securestring
$credential = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user,$pass

user - zmienna, która pobierze login z pliku cred_user.txt
pass - zmienna, która pobierze zaszyfrowane hasło z pliku cred_password.txt
credential - zmienna do której przypisany będzie nowy obiekt w którym będzie od razu zapisany login i hasło w zrozumiał dla skryptów sposób - pozwala to na automatyzację procesu logowania do serwerów