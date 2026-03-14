<#
.SYNOPSIS
    Disables the Windows Installer "Always install with elevated privileges" setting to meet STIG WN11-CC-000315.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : Not listed in the provided STIG-Implementation PDF for this STIG
    Plugin IDs      : Not listed in the provided STIG-Implementation PDF for this STIG
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Not provided
    PowerShell Ver. : Not provided

.USAGE
    Run in an elevated PowerShell session.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-CC-000315).ps1
#>

$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$valueName = 'AlwaysInstallElevated'

# Create the key if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the STIG-required value
New-ItemProperty -Path $regPath -Name $valueName -PropertyType DWord -Value 0 -Force | Out-Null

# Verification
Get-ItemProperty -Path $regPath -Name $valueName | Select-Object $valueName
