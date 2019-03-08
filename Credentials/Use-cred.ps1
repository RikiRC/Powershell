$user = get-content cred_user.txt
$pass = get-content cred_password.txt | convertto-securestring

$credential = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user,$pass

echo $user, $pass, $credential