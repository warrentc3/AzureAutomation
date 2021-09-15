$ADSystemInfo = New-Object -ComObject "ADSystemInfo"
$NetBIOSDomain = $ADSystemInfo.GetType().InvokeMember("DomainShortName", "GetProperty", $null, $ADSystemInfo, $null)
$Identity = $NetBIOSDomain + "\KTB-SystemMonitoring-ADS-GLBL_ServiceAccounts"
$ID = New-Object System.Security.Principal.NTAccount($Identity)
$SID= $ID.Translate( [System.Security.Principal.SecurityIdentifier] ).toString()
[string]$ComputerName = $env:Computername

###  1. Set permissions on Service Control Manager
###  2. Set local group memberships for DCOM/Perfmon
###  3. Set registry keys for DCOM HTTP access
###  4. Set DCOM Remote Access / Remote Activation permissions
###  5. Set WMI permissions on "root/CIMV2" and "root/default" namespaces

#### Add permissions to Service Control Manager equivalent to NT AUTHORITY\Interactive User
$SCPERMS = "(A;;CCLCRPRC;;;$($SID))"
$SCMSDDL = cmd /c 'sc sdshow scmanager'
$modify = ([string]$SCMSDDL).TrimEnd().TrimStart()
$SDDL = [string](($modify -split 'S:')[0] + $SCPERMS + 'S:' +($modify -split 'S:')[1])
$SDDL = [string](($SDDL).TrimEnd().TrimStart())
if ( $modify -match $SCPERMS ) {} else {cmd /c "sc sdset scmanager ""$($SDDL)"""}

#### Add local group memberships needed
$localgroups = @("Distributed COM Users","Performance Monitor Users" )
foreach($localgroup in $localgroups){
$Existing = $null; $Existing = Get-LocalGroupMember -Group $localgroup
if ($SID -notin $Existing.SID.Value) { Add-LocalGroupMember -Group $localgroup -Member $Identity }
else {}
}

#### VERIFIES REGISTRY KEYS ARE PRESENT FOR DCOM SECURITY
# Names of the registry keys that control COM permissions
$registryKeys = @("MachineLaunchRestriction",
                    "MachineAccessRestriction",
                    "DefaultLaunchPermission",
                    "DefaultAccessPermission")
# Location of the registry keys
$parentPathRegistryKeyModified = "HKLM:\\SOFTWARE\\Microsoft\\Ole\\"
$parentPathRegistryKey = "HKLM:\SOFTWARE\Microsoft\Ole"
$RegKeys = Get-ItemProperty $parentPathRegistryKey
if ($null -eq $RegKeys.EnableDCOM) { New-ItemProperty -Path $parentPathRegistryKey -Name "EnableDCOM" -Value ”Y” -PropertyType "String" } 
elseif ($RegKeys.EnableDCOM -ne "Y") { Set-ItemProperty -Path $parentPathRegistryKey -Name "EnableDCOM" -Value "Y" }
else {}
if ($null -eq $RegKeys.EnableDCOMHTTP) { New-ItemProperty -Path $parentPathRegistryKey -Name "EnableDCOMHTTP" -Value ”Y” -PropertyType "String" } 
elseif ($RegKeys.EnableDCOMHTTP -ne "Y") { Set-ItemProperty -Path $parentPathRegistryKey -Name "EnableDCOMHTTP" -Value "Y" }
else {}
if ($null -eq $RegKeys.LegacySecureReferences) { New-ItemProperty -Path $parentPathRegistryKey -Name "LegacySecureReferences" -Value ”Y” -PropertyType "String" } 
elseif ($RegKeys.LegacySecureReferences -ne "Y") { Set-ItemProperty -Path $parentPathRegistryKey -Name "LegacySecureReferences" -Value "Y" }
else {}
if ($null -eq $RegKeys.LegacyAuthenticationLevel) { New-ItemProperty -Path $parentPathRegistryKey -Name "LegacyAuthenticationLevel" -Value ”0” -PropertyType "DWORD" } 
elseif ($RegKeys.LegacyAuthenticationLevel -ne "0") { Set-ItemProperty -Path $parentPathRegistryKey -Name "LegacyAuthenticationLevel" -Value "0" }
else {}
if ($null -eq $RegKeys.LegacyImpersonationLevel) { New-ItemProperty -Path $parentPathRegistryKey -Name "LegacyImpersonationLevel" -Value ”3” -PropertyType "DWORD" } 
elseif ($RegKeys.LegacyImpersonationLevel -ne "3") { Set-ItemProperty -Path $parentPathRegistryKey -Name "LegacyImpersonationLevel" -Value "3" }
else {}


#Define function to test for presence of registry key
#Source: http://www.jonathanmedd.net/2014/02/testing-for-the-presence-of-a-registry-key-and-value.html
function Test-RegistryValue {
    param (
        $Path,
        $Value
    )
    try {
        Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
        }
}
# Check that all four target registry keys exist
foreach ($registryKey in $registryKeys) {
    if ( !(Test-RegistryValue -Path $parentPathRegistryKey -Value $registryKey) ) {
        # For some reason the registry key "DefaultAccessPermission" doesn't show up. If it's not there,
        # simply create it and initialize it with the value of the registry key "DefaultLaunchPermission"
        if(  ($registryKey -eq "DefaultAccessPermission") ) {
            if (Test-RegistryValue -Path $parentPathRegistryKey -Value "DefaultLaunchPermission") {    
                $DCOMDefaultLaunchPermission = (Get-ItemProperty $parentPathRegistryKeyModified -Name "DefaultLaunchPermission").DefaultLaunchPermission
                New-ItemProperty -Path $parentPathRegistryKey -Name $registryKey -Value $DCOMDefaultLaunchPermission -PropertyType BINARY -Force
            } else{
                throw "The registry key [DefaultAccessPermission] and [DefaultLaunchPermission] were not found."
            }
        }
        else{
            throw "The registry key [$registryKey] was not found."
        }
    }
}


#MachineLaunchRestriction - Local Launch, Remote Launch, Local Activation, Remote Activation
$DCOMSDDLMachineLaunchRestriction = "A;;CCDCLCSWRP;;;$sid"

#MachineAccessRestriction - Local Access, Remote Access
$DCOMSDDLMachineAccessRestriction = "A;;CCDCLC;;;$sid"

#DefaultLaunchPermission - Local Launch, Remote Launch, Local Activation, Remote Activation
$DCOMSDDLDefaultLaunchPermission = "A;;CCDCLCSWRP;;;$sid"

#DefaultAccessPermision - Local Access, Remote Access
$DCOMSDDLDefaultAccessPermision = "A;;CCDCLC;;;$sid"

#PartialMatch
$DCOMSDDLPartialMatch = "A;;\w+;;;$sid"

Write-Output "`nWorking on principal $account ($sid):"
# Get the respective binary values of the DCOM registry entries
$DCOMMachineLaunchRestriction = (Get-ItemProperty $parentPathRegistryKeyModified -Name "MachineLaunchRestriction").MachineLaunchRestriction
$DCOMMachineAccessRestriction = (Get-ItemProperty $parentPathRegistryKeyModified -Name "MachineAccessRestriction").MachineAccessRestriction
$DCOMDefaultLaunchPermission = (Get-ItemProperty $parentPathRegistryKeyModified -Name "DefaultLaunchPermission").DefaultLaunchPermission
$DCOMDefaultAccessPermission = (Get-ItemProperty $parentPathRegistryKeyModified -Name "DefaultAccessPermission").DefaultAccessPermission


# Convert the current permissions to SDDL
Write-Output "`tConverting current permissions to SDDL format..."
$converter = new-object system.management.ManagementClass Win32_SecurityDescriptorHelper
$CurrentDCOMSDDLMachineLaunchRestriction = $converter.BinarySDToSDDL($DCOMMachineLaunchRestriction)
$CurrentDCOMSDDLMachineAccessRestriction = $converter.BinarySDToSDDL($DCOMMachineAccessRestriction)
$CurrentDCOMSDDLDefaultLaunchPermission = $converter.BinarySDToSDDL($DCOMDefaultLaunchPermission)
$CurrentDCOMSDDLDefaultAccessPermission = $converter.BinarySDToSDDL($DCOMDefaultAccessPermission)

# Build the new permissions
Write-Output "`tBuilding the new permissions..."
if (($CurrentDCOMSDDLMachineLaunchRestriction.SDDL -match $DCOMSDDLPartialMatch) -and ($CurrentDCOMSDDLMachineLaunchRestriction.SDDL -notmatch $DCOMSDDLMachineLaunchRestriction))
{
    $NewDCOMSDDLMachineLaunchRestriction = $CurrentDCOMSDDLMachineLaunchRestriction.SDDL -replace $DCOMSDDLPartialMatch, $DCOMSDDLMachineLaunchRestriction
}
else
{
    $NewDCOMSDDLMachineLaunchRestriction = $CurrentDCOMSDDLMachineLaunchRestriction.SDDL += "(" + $DCOMSDDLMachineLaunchRestriction + ")"
}
  
if (($CurrentDCOMSDDLMachineAccessRestriction.SDDL -match $DCOMSDDLPartialMatch) -and ($CurrentDCOMSDDLMachineAccessRestriction.SDDL -notmatch $DCOMSDDLMachineAccessRestriction))
{
    $NewDCOMSDDLMachineAccessRestriction = $CurrentDCOMSDDLMachineAccessRestriction.SDDL -replace $DCOMSDDLPartialMatch, $DCOMSDDLMachineLaunchRestriction
}
else
{
    $NewDCOMSDDLMachineAccessRestriction = $CurrentDCOMSDDLMachineAccessRestriction.SDDL += "(" + $DCOMSDDLMachineAccessRestriction + ")"
}

if (($CurrentDCOMSDDLDefaultLaunchPermission.SDDL -match $DCOMSDDLPartialMatch) -and ($CurrentDCOMSDDLDefaultLaunchPermission.SDDL -notmatch $DCOMSDDLDefaultLaunchPermission))
{
    $NewDCOMSDDLDefaultLaunchPermission = $CurrentDCOMSDDLDefaultLaunchPermission.SDDL -replace $DCOMSDDLPartialMatch, $DCOMSDDLDefaultLaunchPermission
}
else
{
    $NewDCOMSDDLDefaultLaunchPermission = $CurrentDCOMSDDLDefaultLaunchPermission.SDDL += "(" + $DCOMSDDLDefaultLaunchPermission + ")"
}
     
if (($CurrentDCOMSDDLDefaultAccessPermission.SDDL -match $DCOMSDDLPartialMatch) -and ($CurrentDCOMSDDLDefaultAccessPermission.SDDL -notmatch $DCOMSDDLDefaultAccessPermision))
{
    $NewDCOMSDDLDefaultAccessPermission = $CurrentDCOMSDDLDefaultAccessPermission.SDDL -replace $DCOMSDDLPartialMatch, $DCOMSDDLDefaultAccessPermision
}
else
{
    $NewDCOMSDDLDefaultAccessPermission = $CurrentDCOMSDDLDefaultAccessPermission.SDDL += "(" + $DCOMSDDLDefaultAccessPermision + ")"
}
     
# Convert SDDL back to Binary
Write-Output "`tConverting SDDL back into binary form..."
$DCOMbinarySDMachineLaunchRestriction = $converter.SDDLToBinarySD($NewDCOMSDDLMachineLaunchRestriction)
$DCOMconvertedPermissionsMachineLaunchRestriction = ,$DCOMbinarySDMachineLaunchRestriction.BinarySD

$DCOMbinarySDMachineAccessRestriction = $converter.SDDLToBinarySD($NewDCOMSDDLMachineAccessRestriction)
$DCOMconvertedPermissionsMachineAccessRestriction = ,$DCOMbinarySDMachineAccessRestriction.BinarySD

$DCOMbinarySDDefaultLaunchPermission = $converter.SDDLToBinarySD($NewDCOMSDDLDefaultLaunchPermission)
$DCOMconvertedPermissionDefaultLaunchPermission = ,$DCOMbinarySDDefaultLaunchPermission.BinarySD

$DCOMbinarySDDefaultAccessPermission = $converter.SDDLToBinarySD($NewDCOMSDDLDefaultAccessPermission)
$DCOMconvertedPermissionsDefaultAccessPermission = ,$DCOMbinarySDDefaultAccessPermission.BinarySD

# Apply the changes
Write-Output "`tApplying changes..."
#Set-ItemProperty $parentPathRegistryKeyModified -Name "MachineLaunchRestriction" -Value $DCOMbinarySDMachineLaunchRestriction.binarySD
#Write-Output "  Applied MachineLaunchRestricition complete."

#Set-ItemProperty $parentPathRegistryKeyModified -Name "MachineAccessRestriction" -Value $DCOMbinarySDMachineAccessRestriction.binarySD
#Write-Output "  Applied MachineAccessRestricition complete."

Set-ItemProperty $parentPathRegistryKeyModified -Name "DefaultLaunchPermission" -Value $DCOMbinarySDDefaultLaunchPermission.binarySD
Write-Output "  Applied DefaultLaunchPermission complete."

Set-ItemProperty $parentPathRegistryKeyModified -Name "DefaultAccessPermission" -Value $DCOMbinarySDDefaultAccessPermission.binarySD
Write-Output "  Applied DefaultAccessPermission complete."


####  SET WMI NAMESPACE PERMISSIONS 
Function Set-WmiNamespaceSecurity {
    <#
    .SYNOPSIS
    Set WMI Permissions for a security entity
    .NOTES 
    Copyright (c) Microsoft Corporation.  All rights reserved. 
    For personal use only.  Provided AS IS and WITH ALL FAULTS
    Modifications made by vNicklas are included.
    .LINK
    http://blogs.msdn.com/b/wmi/archive/2009/07/27/scripting-wmi-namespace-security-part-3-of-3.aspx
    .LINK
    http://vniklas.djungeln.se/2012/08/22/set-up-non-admin-account-to-access-wmi-and-performance-data-remotely-with-powershell/
    .EXAMPLE
    Set-WmiNamespaceSecurity root/cimv2 add steve Enable,RemoteAccess
    #>
 
    Param ( [parameter(Mandatory=$true,Position=0)][string] $namespace,
        [parameter(Mandatory=$true,Position=1)][string] $operation,
        [parameter(Mandatory=$true,Position=2)][string] $account,
        [parameter(Position=3)][string[]] $permissions = $null,
        [bool] $allowInherit = $false,
        [bool] $deny = $false,
        [string] $computer = ".",
        [System.Management.Automation.PSCredential] $credential = $null)
   
    Process {
        $ErrorActionPreference = "Stop"
 
        Function Get-AccessMaskFromPermission($permissions) {
            $WBEM_ENABLE            = 1
                    $WBEM_METHOD_EXECUTE = 2
                    $WBEM_FULL_WRITE_REP   = 4
                    $WBEM_PARTIAL_WRITE_REP              = 8
                    $WBEM_WRITE_PROVIDER   = 0x10
                    $WBEM_REMOTE_ACCESS    = 0x20
                    $WBEM_RIGHT_SUBSCRIBE = 0x40
                    $WBEM_RIGHT_PUBLISH      = 0x80
        	    $READ_CONTROL = 0x20000
        	    $WRITE_DAC = 0x40000
       
            $WBEM_RIGHTS_FLAGS = $WBEM_ENABLE,$WBEM_METHOD_EXECUTE,$WBEM_FULL_WRITE_REP,
                $WBEM_PARTIAL_WRITE_REP,$WBEM_WRITE_PROVIDER,$WBEM_REMOTE_ACCESS,
                $READ_CONTROL,$WRITE_DAC
            $WBEM_RIGHTS_STRINGS = "Enable","MethodExecute","FullWrite","PartialWrite",
                "ProviderWrite","RemoteAccess","ReadSecurity","WriteSecurity"
 
            $permissionTable = @{}
 
            for ($i = 0; $i -lt $WBEM_RIGHTS_FLAGS.Length; $i++) {
                $permissionTable.Add($WBEM_RIGHTS_STRINGS[$i].ToLower(), $WBEM_RIGHTS_FLAGS[$i])
            }
       
            $accessMask = 0
 
            foreach ($permission in $permissions) {
                if (-not $permissionTable.ContainsKey($permission.ToLower())) {
                    throw "Unknown permission: $permission" + "Valid permissions: $($permissionTable.Keys)"
                }
                $accessMask += $permissionTable[$permission.ToLower()]
            }
       
            $accessMask
        }
 
        if ($PSBoundParameters.ContainsKey("Credential")) {
            $remoteparams = @{ComputerName=$computer;Credential=$credential}
        } else {
            $remoteparams = @{ComputerName=$computerName}
        }
       
        $invokeparams = @{Namespace=$namespace;Path="__systemsecurity=@"} + $remoteParams
 
        $output = Invoke-WmiMethod @invokeparams -Name GetSecurityDescriptor
        if ($output.ReturnValue -ne 0) {
            throw "GetSecurityDescriptor failed: $($output.ReturnValue)"
        }
 
        $acl = $output.Descriptor
        $OBJECT_INHERIT_ACE_FLAG = 0x1
        $CONTAINER_INHERIT_ACE_FLAG = 0x1
 
        $computerName = $env:Computername
   

 
        switch ($operation) {
            "add" {
                if ($permissions -eq $null) {
                    throw "-Permissions must be specified for an add operation"
                }
                $accessMask = Get-AccessMaskFromPermission($permissions)
   
                $ace = (New-Object System.Management.ManagementClass("win32_Ace")).CreateInstance()
                $ace.AccessMask = $accessMask
                if ($allowInherit) {
                    $ace.AceFlags = $OBJECT_INHERIT_ACE_FLAG + $CONTAINER_INHERIT_ACE_FLAG
                } else {
                    $ace.AceFlags = 0
                }
                       
                $Identity = (New-Object System.Management.ManagementClass("win32_Trustee")).CreateInstance()
                $Identity.SidString = $SID
                $ace.Trustee = $Identity
           
                $ACCESS_ALLOWED_ACE_TYPE = 0x0
                $ACCESS_DENIED_ACE_TYPE = 0x1
 
                if ($deny) {
                    $ace.AceType = $ACCESS_DENIED_ACE_TYPE
                } else {
                    $ace.AceType = $ACCESS_ALLOWED_ACE_TYPE
                }
 
                $acl.DACL += $ace.psobject.immediateBaseObject
	    
            }
       
            "delete" {
                if ($permissions -ne $null) {
                    throw "Permissions cannot be specified for a delete operation"
                }
       
                [System.Management.ManagementBaseObject[]]$newDACL = @()
                foreach ($ace in $acl.DACL) {
                    if ($ace.Trustee.SidString -ne $SID) {
                        $newDACL += $ace.psobject.immediateBaseObject
                    }
                }
 
                $acl.DACL = $newDACL.psobject.immediateBaseObject
            }
       
            default {
                throw "Unknown operation: $operation`nAllowed operations: add delete"
            }
        }
 
        $setparams = @{Name="SetSecurityDescriptor";ArgumentList=$acl.psobject.immediateBaseObject} + $invokeParams
 
        $output = Invoke-WmiMethod @setparams
        if ($output.ReturnValue -ne 0) {
            throw "SetSecurityDescriptor failed: $($output.ReturnValue)"
        }
    }
} #function Set-WmiNameSpaceSecurity
$WMINamespaceSecurityParams = @{
    Namespace = "root/CIMv2"
    Account = $Identity
    Operation = "add"
    Computer = $ComputerName
}
Set-WMINamespaceSecurity @WMINamespaceSecurityParams -allowInherit $true -Permissions Enable,MethodExecute,ReadSecurity,RemoteAccess
$WMINamespaceSecurityParams = @{
    Namespace = "root\default"
    Account = $Identity
    Operation = "add"
    Computer = $ComputerName
}
Set-WMINamespaceSecurity @WMINamespaceSecurityParams -allowInherit $true -Permissions Enable,MethodExecute,ReadSecurity,RemoteAccess


Stop-Service iphlpsvc
Stop-Service UALSVC
Restart-Service Winmgmt
Start-Service iphlpsvc
Start-Service UALSVC
