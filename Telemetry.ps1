<#
    Script description.

    Some notes.
#>
param (
    # name of the output prefix folder, useful for competitions
    [string]$prefix = "",

    #get robot logs?
    [boolean]$robot = $false,

    # Team number
    [int]$team = 0000,

    # Robot log locations
    [string[]]$riodirs = "/home/lvuser/logs"


)
$oldloc
if ($prefix -ne "") {
    New-Item -ItemType Directory -Force -Path $prefix
    $oldloc = $pwd
    Set-Location $prefix
}

if ($remotelogdir) {
    $remotelogdir
}

robocopy /xc /xn /xo "C:\Users\Public\Documents\FRC\Log Files" (Join-Path (($pwd).path) "\logs\driverstation")

if ($robot) {
    if ($teamnum -ne 0000) {
        Set-Location $oldloc
        throw Write-Error "Need a team number to do remote! Specifiy the team number with '-team = xxxx'"
    }
    $hostname = ("roboRIO-" + $teamnum + "-frc.local")
    scp.exe -r "lvuser@${hostname}:${remotedir}" (Join-Path (($pwd).path) "\logs\robot")
}

set-Location $oldloc
