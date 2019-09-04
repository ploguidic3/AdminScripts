$Outlook = New-Object -ComObject Outlook.Application
# Import CSV
$csv = Import-Csv "C:\test\MailingList.csv"
# For loop to iterate through the csv.
for($i=0; $i -lt $csv.Count; $i++){
    $Mail = $Outlook.CreateItem(0)
    $Mail.To = "Cherwell@bayada.com"
    $Mail.Subject = "Seperation $($csv[$i].Worker) $($csv[$i]."Employee ID") $($csv[$i]."Cost Center") $($csv[$i]."Termination Date") forward to $($csv[$i]."Supervisory Organization")"
    $Mail.Body =  "Seperation $($csv[$i].Worker) $($csv[$i]."Employee ID") $($csv[$i]."Cost Center") $($csv[$i]."Termination Date") forward to $($csv[$i]."Supervisory Organization")"


    # You can do the same with csv and the headers you need
    #csv[$i].header


    $Mail.Send()
    
}
