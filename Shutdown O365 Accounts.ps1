#This script is designed to take users from a termination report and move them to a non-syncing OU
#
#Pulls in the CSV (replace %username% with your Username)
$csv = Import-csv "C:\Users\%username%\Documents\Termination Reports\Terminated Users.csv"
#Sets TargetOU variable as Bayada Disabled Users
$TargetOU = "OU=Example OU,DC=Example DC,DC=Example DC,DC=Example DC"
##Loops through csv
for($i=0; $i -lt $csv.Count; $i++){
#Pulls User Distinguished Name based on SamAccountName
$UserDN = (Get-ADUser -Identity $($csv[$i].samaccountname)).distinguishedName
#clears active directory groups
Get-ADUser $($csv[$i].samaccountname) -Properties MemberOf | Select -Expand MemberOf | %{Remove-ADGroupMember $_ -member $($csv[$i].samaccountname) -confirm:$false -ErrorAction SilentlyContinue}
#clears manager and phone numbers
Set-ADuser $($csv[$i].samaccountname) -clear manager,telephoneNumber, ipPhone, otherIpPhone, pager, facsimileTelephoneNumber -ErrorAction SilentlyContinue 
#Moves Object to Disabled Users OU and this will inactivate the e3 license, hide them in the GAL and add a bounceback
Move-ADObject -Identity $UserDN -TargetPath $TargetOU
}
