$Outlook = New-Object -ComObject Outlook.Application
# Import CSV
$csv = Import-Csv "C:\test\MailingList.csv"
# For loop to iterate through the csv.
for($i=0; $i -lt $csv.Count; $i++){
    $Mail = $Outlook.CreateItem(0)
    $Mail.To = $csv[$i].email
    $Mail.Subject = "Seperation $($csv[$i].Worker)"
    $Mail.Body =  "Hello $($csv[$i]."Supervisory Organization"), 

$($csv[$i].Worker)'s e-mail account was recently forwarded to you.  (Please respect the privacy of any personal e-mails that may be received.) 
 
    1. Login to your Bayada Mail account via the Portal.`n
    2. After your mail has displayed, click the drop-down arrow next to your name in the upper-right corner to 'Open Other Mailbox'.`n
    3. Enter the employee’s last name in the 'Select mailbox' field. Then click on 'Open'.`n
 
You may also view the mailbox from within your Outlook.  Simply close and reopen Outlook, and the additional mailbox should display below your original folders.
 
Please call me if you need more help with that.  I've scheduled the forward to remain in place for 3 weeks.

Thanks,

Joe LoGuidice
Associate, Provisioning | DES | BAYADA Home Health Care
4300 Haddonfield Rd | Pennsauken Township, NJ 08109
Office: 215-757-9000 | Cisco Ext: 0511-55 | bayada.com"

    # You can do the same with csv and the headers you need
    #csv[$i].header


    $Mail.Send()
    
}