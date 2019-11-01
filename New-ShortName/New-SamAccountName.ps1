. New-ShortName.ps1

$NamePrefFirst = "Joffrey"
$NamePrefLast = "Baratheon"
$NameLegalFirst = "Joffrey"
$NameLegalMiddle = "Baratheon"
$NameLegalLast = "Lannister"
$NameReporting = "King Joffrey"

$updatemailnick = New-ShortName -PrefFirstName $NamePrefFirst -PrefLastName $NamePrefLast `
-LegalFirstName $NameLegalFirst -LegalMiddleName $NameLegalMiddle -LegalLastName $NameLegalLast `
-ReportingName $NameReporting -ExistingSAMs $allsam


Set-AzureADUser -ObjectId $_.UserPrincipalName -MailNickName $updatemailnick
$allsam += $updatemailnick 
Write-Host $_.UserPrincipalName "|" $updatemailnick}
