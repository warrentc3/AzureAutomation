. New-StringConversion.ps1
##https://github.com/PsCustomObject/New-StringConversion

function New-ShortName {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        $PrefFirstName,
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        $PrefLastName,
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        $LegalFirstName,
        [Parameter(Mandatory=$false,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        $LegalMiddleName,
        [Parameter(Mandatory=$false,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        $LegalLastName,
        [Parameter(Mandatory=$false,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        $ReportingName,
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        $ExistingSAMs,
        [Parameter(Mandatory=$false)]
        $NewSAM
    )

    Begin{
        If  ($PrefFirstName -like "Md.*" -and $PrefFirstName.Length -gt 4){$FirstName   = $PrefFirstName.Trim("Md."); $FirstName = $FirstName -replace '\W+', ""; $FirstName = New-StringConversion -StringToConvert $FirstName -RemoveSpaces;}    
        Else{
        ##$FirstName = $PrefFirstName -replace '\W+', ""; $FirstName = New-StringConversion -StringToConvert $FirstName -RemoveSpaces }
        $FirstName = (New-StringConversion -StringToConvert $PrefFirstName -RemoveSpaces) -replace '\W+', "" }
        $LastName    = $PrefLastName -replace '\W+', ""; try{$LastName = New-StringConversion -StringToConvert $LastName -RemoveSpaces} catch{};
        $LegalFirst  = $LegalFirstName     -replace '\W+', ""; try{$LegalFirst = New-StringConversion -StringToConvert $LegalFirst -RemoveSpaces} catch{};
        $LegalMiddle = $LegalMiddleName    -replace '\W+', ""; try{$LegalMiddle = New-StringConversion -StringToConvert $LegalMiddle -RemoveSpaces} catch{};
        $LegalLast   = $LegalLastName      -replace '\W+', ""; try{$LegalLast = New-StringConversion -StringToConvert $LegalLast -RemoveSpaces} catch{};
        $NameReporting = $ReportingName.Replace("）"," ").TrimEnd()

### Only display name
        If ( [string]::IsNullOrWhiteSpace($LegalFirst) -and [string]::IsNullOrWhiteSpace($LegalMiddle) -and [string]::IsNullOrWhiteSpace($LegalLast) -and [string]::IsNullOrWhiteSpace($FirstName)  -and [string]::IsNullOrWhiteSpace($LastName) ){
        $NameReporting = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($NameReporting))
        $FirstName = $NameReporting.split(" ")[0]; $LastName = ($NameReporting.Trim($NameReporting.split(" ")[0])).TrimStart().TrimEnd();
    }

    $first = $null; $middle = $null; $last = $null;$badsam = $null
    if (![string]::IsNullOrWhiteSpace($LegalMiddle) -and ($LegalMiddle -ne $FirstName )){ $middle = $LegalMiddle.Substring(0,1).ToUpper() };
    if ($FirstName.Length -ge 8){$first = $FirstName.Substring(0,8).ToUpper()} else {$first = $FirstName.ToUpper()};
    if ($LastName.Length -ge 8) {$last  = $LastName.Substring(0,8).ToUpper()}  else {$last = $LastName.ToUpper()}
    $first = [string]$first; $middle = [string]$middle; $last = [string]$last;
    }
    
    Process{
    
:Outer Do {
### Only first name
    If ( [string]::IsNullOrWhiteSpace($LegalMiddle) -and [string]::IsNullOrWhiteSpace($LegalLast) -and  [string]::IsNullOrWhiteSpace($LastName) -and ![string]::IsNullOrWhiteSpace($FirstName) ) {
        $NewSAM = $first; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {break :Outer;$ExistingSAMs += $NewSAM.ToLower();$ExistingSAMs += $NewSAM.ToLower(); $i++; $pass++}
        $onechar =  $first.Length - 1; $NewSAM = $first; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {break :Outer;$ExistingSAMs += $NewSAM.ToLower();$ExistingSAMs += $NewSAM.ToLower(); $i++; $pass++}
        }
### First >= 4 & Last  >= 4
    If ( ($first.Length -ge 4) -and ( $last.Length -ge 4 ) ) {
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,4); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {break :Outer;$ExistingSAMs += $NewSAM.ToLower();$ExistingSAMs += $NewSAM.ToLower(); $i++; $pass++}
            if ($first.Length -gt 5){
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,3); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,2); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            }
            if ($last.Length -gt 5){
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,5); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,6); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}            
            $NewSAM = $first.Substring(0,2) + $last.Substring(0,5) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            }
            if ( $middle -ne $null ){
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,3); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,4); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,3) + $middle + $last.Substring(0,3) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,2) + $middle + $last.Substring(0,4) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            }
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
        $NewSAM = $first.Substring(0,3) + $last.Substring(0,4) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
    }
### First >= 4 & Last < 4
    ElseIf ( ($first.Length -ge 4) -and ( $last.Length -lt 4 ) ) {
            If ( ($first.Length -ge 7) -and ( $last.Length -eq 1 ) ){
                $NewSAM = $first.Substring(0,7) + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    if ($middle -ne $null) {
                    $NewSAM = $first.Substring(0,6) + $middle + $last ; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
            }
            ElseIf ( ($first.Length -ge 7) -and ( $last.Length -eq 2 ) ){
                $NewSAM = $first.Substring(0,7) + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,2); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    if ($middle -ne $null){
                    $NewSAM = $first.Substring(0,6) + $middle + $last.Substring(0,1) ; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,2) ; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1)  + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,2)  + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                }
            ElseIf ( ($first.Length -ge 7) -and ( $last.Length -eq 3 ) ){
                $NewSAM = $first.Substring(0,5) + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,2); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,7) + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,4) + $last.Substring(0,3) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first.Substring(0,6) + $middle + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,2); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,4) + $middle + $last.Substring(0,3); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                }
            ElseIf ( ($first.Length -eq 6) -and ( $last.Length -eq 1 ) ){
                $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                $NewSAM = $first + $last +  "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last +  "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "10"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "11"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "12"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "13"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "14"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "15"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "16"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "17"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "18"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "19"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "20"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            ElseIf ( ($first.Length -eq 6) ){
                $NewSAM = $first + $last.Substring(0,2); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first + $middle + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,6) + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            ElseIf ( ($first.Length -eq 5) -and ( $last.Length -le 2 ) ){
                $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first + $middle + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            }
            ElseIf ( ($first.Length -eq 5) -and ( $last.Length -eq 3 ) ){
                $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first + $middle + $last.Substring(0,1); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first.Substring(0,5) + $middle + $last.Substring(0,1) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first.Substring(0,5) + $last.Substring(0,2) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            ElseIf ( ($first.Length -eq 4) ){
                $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                        if ($last.Length -eq 3){
                        $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,2) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                        else {
                        $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    }
                $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    if ($last.Length -lt 3){
                    $NewSAM = $first + $last + "10"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "11"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "12"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "13"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "14"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "15"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "16"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "17"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "18"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "19"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "20"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
            }
    }
### First < 4  & Last  >= 4    
    ElseIf ( ($first.Length -lt 4) -and ( $last.Length -ge 4 ) ){
        If ( $first.Length -eq 1 ){
                If ( $last.Length -ge 7){
                    $NewSAM = $first + $last.Substring(0,7); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first + $middle + $last.Substring(0,6); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                    $NewSAM = $first + $last.Substring(0,6) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,6) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
                ElseIf ($last.Length -eq 6){
                    $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                    $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $middle + $last.Substring(0,5) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                    $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
                Else{
                $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    }
                $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            }
        ElseIf ($first.Length -eq 2){
                If ($last.Length -ge 6){
                    $NewSAM = $first + $last.Substring(0,6); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last.Substring(0,5); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,4) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    $NewSAM = $first + $last.Substring(0,5) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,5) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
                ElseIf ($last.Length -eq 5){
                    $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,5) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
                ElseIf ($last.Length -eq 4){
                    $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            }
        ElseIf ($first.Length -eq 3){
                If ($last.Length -ge 6){
                    $NewSAM = $first + $last.Substring(0,5); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last.Substring(0,4); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    $NewSAM = $first + $last.Substring(0,4) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last.Substring(0,4) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
                ElseIf ($last.Length -eq 5){
                    $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last.Substring(0,4); if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last.Substring(0,3) + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
                ElseIf ($last.Length -eq 4){
                    $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        If ($middle -ne $null){
                        $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        $NewSAM = $first + $middle + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                        }
                    $NewSAM = $first + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                    $NewSAM = $first + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            }
    }
### First < 4  & Last  < 4
    ElseIf ( ($first.Length -lt 4) -and ( $last.Length -lt 4 ) ){
        $NewSAM = $first + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            If ($middle -ne $null) {
                $NewSAM = $first + $middle + $last; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                $NewSAM = $first + $middle + $last + "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
                }
            $NewSAM = $first + $last +  "2"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "3"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "4"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "5"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "6"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "7"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "8"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last +  "9"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "10"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "11"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "12"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "13"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "14"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "15"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "16"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "17"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "18"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "19"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            $NewSAM = $first + $last + "20"; if($NewSAM.ToLower() -in $ExistingSAMs) {$badsam += $NewSAM.ToLower()} else {$ExistingSAMs += $NewSAM.ToLower(); $i++; break :Outer; $pass++}
            }
} while ( $pass -lt 1)

}
End{
return $NewSAM
}

}
