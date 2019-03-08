read-host "Login" >> cred_user.txt
read-host -AsSecureString "Password" | ConvertFrom-SecureString >> cred_password.txt
