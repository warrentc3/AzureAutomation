Write-Output "Getting Graph API Token"
$creds = Get-AutomationPSCredential -Name 'GraphAPI-Infrastructure'
# Define the values applicable for the application used to connect to the Graph (change these for your tenant)
$AppId = $creds.UserName
$TenantId = "7a7c2d99-79a9-4222-93e8-4d200704e629"
$AppSecret = $creds.GetNetworkCredential().Password

# Construct URI and body needed for authentication
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
$body = @{
    client_id     = $AppId
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $AppSecret
    grant_type    = "client_credentials" }

# Get OAuth 2.0 Token
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing

# Unpack Access Token
$token = ($tokenRequest.Content | ConvertFrom-Json).access_token

# Base URL
$headers = @{Authorization = "Bearer $token"}

$O365Cred = Get-AutomationPSCredential -Name 'WarrenSvcAcct'; Start-Sleep -Seconds 1; Connect-AzureAD -Credential $O365Cred | Out-Null;Connect-MsolService -Credential $O365Cred | Out-Null;

$MsolUsers = (Get-MsolUser -All); $MsolUserNoLic = (Get-MsolUser -All -UnlicensedUsersOnly );$MsolUsers = $MsolUsers | Where-Object {$_.ObjectId -notin $MsolUserNoLic.ObjectId}
$MsolUsers | ForEach-Object -Begin { $i = 0 } -Process       {
if ($i -eq  [math]::Floor( $MsolUsers.count * .1 )) {Write-Output "10% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .2 )) {Write-Output "20% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .3 )) {Write-Output "30% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .4 )) {Write-Output "40% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .5 )) {Write-Output "50% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .6 )) {Write-Output "60% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .7 )) {Write-Output "70% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .8 )) {Write-Output "80% Complete" }
if ($i -eq  [math]::Floor( $MsolUsers.count * .9 )) {Write-Output "90% Complete" }
$objectid = $_.ObjectId;
$URI = "https://graph.microsoft.com/v1.0/users/$($objectid)/reprocessLicenseAssignment";
Start-Sleep -Milliseconds 100;
Invoke-RestMethod -Uri $URI -Headers $Headers -Method Post -UseBasicParsing -ContentType "application/json" -OutFile output.txt;
}
