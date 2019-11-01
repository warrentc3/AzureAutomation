
$AzUsers = (Get-AzureADUser -All $true)
$AzUsers = $AzUsers | Where-Object {$_.UserType -eq "Member"}
$usermails = $AzUsers.ProxyAddresses | Where-Object {$_ -like "smtp*"} | ForEach-Object {$_.ToLower() -replace "smtp:",""}
$names = $usermails | ForEach-Object {($_ -Split("@"))[0]} 
$names += $AzUsers.MailNickName.ToLower()
$names = ($names | Sort-Object | Group-Object).Where({ $_.Name -ne " "}).Name
