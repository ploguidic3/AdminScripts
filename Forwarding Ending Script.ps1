$Outlook = New-Object -ComObject Outlook.Application
# Import CSV
$csv = Import-Csv "C:\test\ForwardEnd.csv"
# For loop to iterate through the csv.
for($i=0; $i -lt $csv.Count; $i++){
    $Mail = $Outlook.CreateItem(0)
    $Mail.To = $csv[$i].email
    $Mail.Subject = "Forwarding Ending $($csv[$i].Worker)"
    $Mail.Body =  "Hello $($csv[$i]."Supervisory Organization"), 

The forwarding for $($csv[$i].Worker)'s e-mail is scheduled to end this Friday. If you would like the forwarding extended please let me know. If you do not need the forwarding extended please feel free to disregard this e-mail. 

Thanks,

Joe LoGuidice
Associate, Provisioning | DES | BAYADA Home Health Care
4300 Haddonfield Rd | Pennsauken Township, NJ 08109
Office: 215-757-9000 | Cisco Ext: 0511-55 | bayada.com"

    # You can do the same with csv and the headers you need
    #csv[$i].header


    $Mail.Send()
    
}