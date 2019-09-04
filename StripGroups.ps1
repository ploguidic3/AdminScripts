#Builds CSV of disabled accounts that have changed within the last 30 days
Get-ADUser -Filter * -Properties samaccountname, whenchanged | Where-Object {$_.DistinguishedName -notlike "*OU=Bayada Mailbox Accounts*" -and $_.Enabled -like "false" -and $_.whenChanged -ge ((Get-Date).AddDays(-30)).Date} | Select samaccountname | export-csv "U:\Scripts\stripgroups.csv" -NoTypeInformation
#Imports newly created CSV
$csv = Import-csv "U:\Scripts\stripgroups.csv"
#Loops through csv
for($i=0; $i -lt $csv.Count; $i++){
#clears active directory groups
Get-ADUser $($csv[$i].samaccountname) -Properties MemberOf | Select -Expand MemberOf | %{Remove-ADGroupMember $_ -member $($csv[$i].samaccountname) -confirm:$false -ErrorAction SilentlyContinue}
#clears manager and phone numbers
Set-ADuser $($csv[$i].samaccountname) -clear manager,telephoneNumber, ipPhone, otherIpPhone, pager, facsimileTelephoneNumber -ErrorAction SilentlyContinue
}