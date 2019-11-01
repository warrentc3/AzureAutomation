. New-ShortName.ps1

## get existing account names & aliases
$AzUsers = (Get-AzureADUser -All $true)
$AzUsers = $AzUsers | Where-Object {$_.UserType -eq "Member"}
$usermails = $AzUsers.ProxyAddresses | Where-Object {$_ -like "smtp*"} | ForEach-Object {$_.ToLower() -replace "smtp:",""}
$names = $usermails | ForEach-Object {($_ -Split("@"))[0]} 
$names += $AzUsers.MailNickName.ToLower()
$names = ($names | Sort-Object | Group-Object).Where({ $_.Name -ne " "}).Name

## First of his name - as per Workday naming structure
$NamePrefFirst = "Joffrey"
$NamePrefLast = "Baratheon"
$NameLegalFirst = "Joffrey"
$NameLegalMiddle = "Baratheon"
$NameLegalLast = "Lannister"
$NameReporting = "King Joffrey"

## create new short/samaccount name 
$updatemailnick = New-ShortName -PrefFirstName $NamePrefFirst -PrefLastName $NamePrefLast `
-LegalFirstName $NameLegalFirst -LegalMiddleName $NameLegalMiddle -LegalLastName $NameLegalLast `
-ReportingName $NameReporting -ExistingSAMs $names

## set new shortname
Set-AzureADUser -ObjectId $_.UserPrincipalName -MailNickName $updatemailnick
$names += $updatemailnick 
Write-Host $_.UserPrincipalName "|" $updatemailnick}



### script to read from application extension properties where workday name data is stored, then update mailnick based on that data. 
### if no WD name data is found, it will leverage a string split of the display name as a fallback.
$updateusers = $AzUsers | Where-Object {($_.mailnickname -like "*.*") -and ![string]::IsNullOrWhiteSpace($_.ExtensionProperty.employeeId)}
acctfix = New-Object -TypeName System.Collections.ArrayList
$updateusers | ForEach-Object {
    $acctfix += [PSCustomObject]@{
        UserPrincipalName = $_.UserPrincipalName
        AccountEnabled = $_.AccountEnabled
        AccountCreated = $_.ExtensionProperty.createdDateTime
        LastPWreset = $_.RefreshTokensValidFromDateTime
        EmployeeID = $_.ExtensionProperty.employeeId
        DisplayName = $_.DisplayName
        DaysSincePWset = (New-TimeSpan -Start ($_.RefreshTokensValidFromDateTime) -End (Get-Date)).Days
        NameLegalFirst = $_.ExtensionProperty.$xNameLegalFirst
        NameLegalMiddle = $_.ExtensionProperty.$xNameLegalMiddle
        NameLegalLast = $_.ExtensionProperty.$xNameLegalLast
        NamePrefFirst = $_.ExtensionProperty.$xNamePrefFirst
        NamePrefLast = $_.ExtensionProperty.$xNamePrefLast
        NameReporting = $_.ExtensionProperty.$xNameReporting
        }
}

$acctfix | Where-Object {![string]::IsNullOrEmpty($_.NameReporting)} | ForEach-Object {$updatemailnick = New-ShortName -PrefFirstName $_.NamePrefFirst -PrefLastName $_.NamePrefLast -LegalFirstName $_.NameLegalFirst -LegalMiddleName $_.NameLegalMiddle -LegalLastName $_.NameLegalLast -ReportingName $_.NameReporting -ExistingSAMs $names;
Set-AzureADUser -ObjectId $_.UserPrincipalName -MailNickName $updatemailnick
$names += $updatemailnick 
Write-Host $_.UserPrincipalName "|" $updatemailnick}

$acctfix | Where-Object {[string]::IsNullOrEmpty($_.NameReporting)} | ForEach-Object {$updatemailnick = New-ShortName -PrefFirstName ($_.DisplayName -split " ")[0] -PrefLastName ($_.DisplayName -split " ")[1] -LegalFirstName ($_.DisplayName -split " ")[0] -LegalMiddleName $_.NameLegalMiddle -LegalLastName ($_.DisplayName -split " ")[1] -ReportingName $_.DisplayName -ExistingSAMs $names;
Set-AzureADUser -ObjectId $_.UserPrincipalName -MailNickName $updatemailnick
$names += $updatemailnick 
Write-Host $_.UserPrincipalName "|" $updatemailnick}
