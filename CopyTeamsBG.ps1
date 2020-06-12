<#
.SYNOPSIS
    The script copies all pictures files from the script path
    to the teams background folder in all user profiles.
.NOTE
    Creator: Mirko CyberSauce / baseVISION
    Dev: Daniel Schädler
    Version: 1.0.0.2
    Help: https://www.reddit.com/r/PowerShell/comments/9ywot9/script_help_copy_file_into_each_users_appdata/
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

foreach ($ProfilePath in $Profiles.FullName) {
    $Destination = Join-Path -Path $ProfilePath -ChildPath $TargetFolder

    try {
    if (-not (Test-Path $Destination -ErrorAction Stop)) {
        New-Item -Path $Destination -Itemtype Directory -ErrorAction Stop
    }
    Copy-Item -Path $pictures -Destination $Destination -Force -ErrorAction Stop
    } catch {}
}