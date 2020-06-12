<#
.SYNOPSIS
    Removes all deployed pictures from the teams background folder
.NOTE
    Creator: CyberSauce/ baseVISION
    Dev: Daniel Sch�dler
    Version: 1.0.0.2
.PARAMETER logFile
    This file will be queried by the detection method.
#>

#Get only the Pictures
$pictures = Get-ChildItem $PSScriptRoot -File | Where-Object { $_.Extension -iin @('.jpg', '.jpeg', '.png') }

#Get all Profiles with Exclude basic Profiles
$Excluded_Profiles = @( 'Default User', 'All Users', 'Default', 'Public' )
$Profiles = Get-ChildItem 'c:\users\' -Directory -force | Where-Object { $_.BaseName -notin $excluded_profiles }

#Get Folder Path to place the Files and Place the Pictures
$targetFolder = "\AppData\Roaming\Microsoft\Teams\Backgrounds\Uploads"

foreach ($ProfilePath in $Profiles.FullName) {
    $Destination = Join-Path -Path $ProfilePath -ChildPath $TargetFolder

    try {
    if (Test-Path $Destination -ErrorAction Stop) {
        Remove-Item "$Destination\*.*" -Force -ErrorAction SilentlyContinue
    }
   } catch {}
}

