<#
.SYNOPSIS
    Remediates WN11-CC-000197 by turning off Microsoft consumer experiences.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : None listed in the provided STIG-Implementation PDF
    Plugin IDs      : None listed in the provided STIG-Implementation PDF
    STIG-ID         : WN11-CC-000197

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1+

.USAGE
    Run from an elevated PowerShell prompt.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-CC-000197).ps1

.VERIFICATION CHECK
    Expected output from #Verification:
    DisableWindowsConsumerFeatures : 1

#>

$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
$ValueName = 'DisableWindowsConsumerFeatures'
$DesiredData = 1

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $DesiredData -Force | Out-Null

# Verification
Get-ItemProperty -Path $RegPath -Name $ValueName | Select-Object DisableWindowsConsumerFeatures