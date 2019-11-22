#Prompts for DC
$DC = Read-Host -Prompt "Enter the Name of the DC"
#Prompts user for group name
$group = Read-Host -Prompt "Enter the Name of the AD group"
#Gets name of CSV to create 
$CSVName = Read-Host -Prompt "Enter the name of the CSV"
#Captures AD accounts in group with relevant content and spits out a CSV
get-adgroupmember -server $DC -identity "$group" -recursive | Get-Aduser -properties mail,employeeNumber,department,Title,employeeType | select name,mail,employeeNumber,department,Title,employeeType  | export-csv "C:\Scripts\$CSVName.csv" -NoTypeInformation
#Tells the user it worked
Write-Host "File created at C:\Scripts\$CSVName.csv. Press any key to exit..."
#Exits when you press any key
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
