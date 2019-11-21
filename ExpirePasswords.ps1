# Import CSV and set variable
$csv = Import-Csv "C:\scripts\PasswordExpire.csv"
# For loop to iterate through the csv.
for($i=0; $i -lt $csv.Count; $i++){
#Sets accounts to expire
Set-ADUser -Identity $($csv[$i].SamAccountName) -PasswordNeverExpires:$False
}
Write-Host " "$csv.Count" account passwords set to expire. Press any key to exit..."
#Exits when you press any key
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 