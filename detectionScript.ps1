<#
.SYNOPSIS
    The scirpt checks if all current logged on users
    has allready get the new teams background images.
.NOTE
    Creator: Cyber Sauce / baseVISION
    Dev: Daniel Sch�dler
    Version: 1.0.0.2
.PARAMETER logFile
    The logfiles stores all the processed user accounts.
    This file will be queried by the detection method.
#>

#Get only the Pictures
$pictures = Get-ChildItem $PSScriptRoot -File | Where-Object { $_.Extension -iin @('.jpg', '.jpeg', '.png') }

#Get all Profiles with Exclude basic Profiles
$Excluded_Profiles = @( 'Default User', 'All Users', 'Default', 'Public' )
$Profiles = Get-ChildItem 'c:\users\' -Directory -force | Where-Object { $_.BaseName -notin $excluded_profiles }

#Get Folder Path to place the Files and Place the Pictures
$targetFolder = "\AppData\Roaming\Microsoft\Teams\Backgrounds\Uploads"

$compliant = $false
foreach ($ProfilePath in $Profiles.FullName) {
    $Destination = Join-Path -Path $ProfilePath -ChildPath $TargetFolder
    $Pictures = Get-ChildItem $Destination -ErrorAction SilentlyContinue | Where-Object { $_.Extension -iin @('.jpg', '.jpeg', '.png') }
    if (($Pictures | Measure-Object).Count -gt 0) {
        $compliant = $true
    }
    #Copy-Item -Path $pictures -Destination $Destination -Force
}
if ($compliant) {'compliant'}

