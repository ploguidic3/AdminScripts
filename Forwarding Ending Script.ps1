$Outlook = New-Object -ComObject Outlook.Application
# Import CSV
$csv = Import-Csv "C:\test\ForwardEnd.csv"
# For loop to iterate through the csv.
for($i=0; $i -lt $csv.Count; $i++){
    $Mail = $Outlook.CreateItem(0)
    $Mail.To = $csv[$i].email
    $Mail.Subject = "Forwarding Ending $($csv[$i].Worker)"
    $Mail.Body =  "Hello $($csv[$i]."Supervisory Organization"), 

Body text

    # You can do the same with csv and the headers you need
    #csv[$i].header


    $Mail.Send()
    
}
