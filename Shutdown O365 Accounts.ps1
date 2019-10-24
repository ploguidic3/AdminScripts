#NOTE: If you got CST to add the separated worker's email to the report you'll need to run a find and replace against that column with find set to "@bayada.com" and replace blank, this will conver the e-mail to the SamAccuntName variable
#you'll also need to rename the column to "samaccountname" or change the variable name in the script below
#This script has to be run from a privliged account, use the Admin file explorer trick to run it with necessary priviliges
#You must copy the ForwardEnd CSV to the same path this script runs in, open the CSV in Notepad, copy the contents, create a new text file in the directory in file explorer admin, past the contents
#and rename your new text file ForwardEnd.csv
#
#Pulls in the CSV (replace jloguidice-a with your -a account)
$csv = Import-csv "C:\Users\jloguidice-a\Documents\Scripts\ForwardEnd.csv"
#Sets TargetOU variable as Bayada Disabled Users
$TargetOU = "OU=Bayada Disabled Users,DC=heroes,DC=bayada,DC=com"
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
