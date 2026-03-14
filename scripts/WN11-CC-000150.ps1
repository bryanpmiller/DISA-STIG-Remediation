<#
.SYNOPSIS
    Remediates WN11-CC-000150 by requiring a password when a computer wakes from sleep while plugged in.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : None listed in the provided STIG-Implementation PDF
    Plugin IDs      : None listed in the provided STIG-Implementation PDF
    STIG-ID         : WN11-CC-000150

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1+

.USAGE
    Run from an elevated PowerShell prompt.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-CC-000150).ps1

.VERIFICATION CHECK
    Expected output from #Verification:
    ACSettingIndex : 1

#>

$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51'
$ValueName = 'ACSettingIndex'
$DesiredData = 1

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $DesiredData -Force | Out-Null

# Verification
Get-ItemProperty -Path $RegPath -Name $ValueName | Select-Object ACSettingIndex