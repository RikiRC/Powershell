### PL ###

read-host "Login" >> cred_user.txt

Pozwala na wprowadzenie loginu w oknie powershella i zapisanie go do pliku cred_user.txt.

----

read-host -AsSecureString "Password" | ConvertFrom-SecureString >> cred_password.txt

Pozwala na wprowadzenie hasła w postaci niejawnej (w oknie konsoli pojawią się gwiazdki "*" a nie hasło) i zapisanie go do pliku cred_password.txt.
Opcja ConvertFrom-SecureString pozwala na zapisanie hasła w postaci zaszyfrowanej w pliku.