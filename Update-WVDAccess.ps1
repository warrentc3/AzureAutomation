function Update-WVDAccess {
    [CmdletBinding(DefaultParameterSetName="Base")]
    param
    (
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        HelpMessage="Windows Virtual Desktop Tenant Unique Name")]
        [ValidateNotNullOrEmpty()]
        $WVDTenant,
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        HelpMessage="Windows Virtual Desktop Host pool Unique Name")]
        [ValidateNotNullOrEmpty()]
        $HostPool,
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        HelpMessage="Windows Virtual Desktop App Group Name")]
        [ValidateNotNullOrEmpty()]
        $AppGroup,
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        HelpMessage="AzureAD Tenant ID")]
        [ValidateNotNullOrEmpty()]
        $AzTenant,
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        HelpMessage="Automation Credential Name for WVD Service Principal")]
        [ValidateNotNullOrEmpty()]
        $WVDServicePrincipal,
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        HelpMessage="Automation Credential Name for AzureAD account with at least User Management role")]
        [ValidateNotNullOrEmpty()]
        $AzADAdmin,
        [Parameter(Mandatory=$true,ParameterSetName="Base",
        ValueFromPipeline=$true,
        HelpMessage="AzureAD Object ID of Security Group used to grant access to WVD")]
        [ValidateNotNullOrEmpty()]
        $AzGroupObjectId,
        [Parameter(Mandatory=$false,ParameterSetName="Base",
        HelpMessage="Designate if AzureAD Domain Services is in use")]
        [Parameter(Mandatory=$true,ParameterSetName="AADDS",
        HelpMessage="Designate if AzureAD Domain Services is in use")]
        [bool]
        $UseAADDS,
        [Parameter(Mandatory=$true,ParameterSetName="AADDS",
        HelpMessage="AzureAD Object ID of Security Group used to synchronize with AzureAD Domain Services")]
        [ValidateNotNullOrEmpty()]
        $AADDSScopedSync
    )

Begin{
$WVDAppCred = Get-AutomationPSCredential -Name $WVDServicePrincipal
$O365Cred = Get-AutomationPSCredential -Name $AzADAdmin
Connect-AzureAD -Credential $O365Cred | Out-Null
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -AadTenantId $AzTenant -Credential $WVDAppCred -ServicePrincipal

$WVDGroupUsers = (Get-AzureADGroupMember -ObjectId $AzGroupObjectId -All $true)
$WVDExistingUsers = (Get-RdsAppGroupUser -TenantName $WVDTenant -HostPoolName $HostPool -AppGroupName $AppGroup).UserPrincipalName
$WVDAddUsers = $WVDGroupUsers | Where-Object {$_.UserPrincipalName -notin $WVDExistingUsers}
$WVDDropUsers = $WVDExistingUsers | Where-Object {$_ -notin $WVDGroupUsers.UserPrincipalName}

}
Process{
## Adds users to AzureAD DS sync group
If ($AADDSScopedSync -ne $null){
$AADDSServicePrincipal = Get-AzureADServicePrincipal -Filter "AppId eq '2565bd9d-da50-47d4-8b85-4c97f669dc36'"
$AADDSSyncGroups = (Get-AzureADServiceAppRoleAssignment -ObjectId $AADDSServicePrincipal.ObjectId | Where-Object {$_.PrincipalType -eq "Group"}).PrincipalId
$AADDSSyncUsers = $AADDSSyncGroups | ForEach-Object {(Get-AzureADGroupMember -ObjectId $_).UserPrincipalName}
$AADDSAddUsers = $WVDAddUsers | Where-Object {$_.UserPrincipalName -notin $AADDSSyncUsers}

$AADDSAddUsers | ForEach-Object {Add-AzureADGroupMember -RefObjectId $_.ObjectId -ObjectId $AADDSScopedSync; Write-Output "Adding" $_.UserPrincipalName " to AADDS sync"}
}
Else{Write-Output "Not synchronizing with AzureAD Domain Services"}


$WVDAddUsers | ForEach-Object {Add-RdsAppGroupUser -TenantName $WVDTenant -HostPoolName $HostPool -AppGroupName $AppGroup -UserPrincipalName $_; Write-Output "Adding" $_.UserPrincipalName " to WVD Access"}
$WVDDropUsers | ForEach-Object {Remove-RdsAppGroupUser -TenantName $WVDTenant -HostPoolName $HostPool -AppGroupName $AppGroup -UserPrincipalName $_; Write-Output "Removing" $_.UserPrincipalName " from WVD Access"}
}

End{
Write-Output "WVD user access update completed."
}

}
