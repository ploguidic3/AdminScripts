$BeginDate=(get-date).AddDays(-90)
$EndDate=(get-date).AddDays(-60)
$OurUsers=Get=ADUser | select-object -Property givenName, sn, emailaddress 
$OurUsers | Where-Object {$_.CreationDate -gt $BeginDate - and $_.CreationDate -lt $EndDate} | Export-CSV C:\users\jloguidice-a\documents\scripts AccountList.csv