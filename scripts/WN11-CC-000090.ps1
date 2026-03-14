<#
.SYNOPSIS
    Enables WN11-CC-000090 so registry-based Group Policy settings are reprocessed even if the GPO has not changed.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : None listed in provided STIG-Implementation PDF
    Plugin IDs      : None listed in provided STIG-Implementation PDF
    STIG-ID         : WN11-CC-000090

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1 / 7.x

.USAGE
    Run from an elevated PowerShell session.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-CC-000090).ps1

.VERIFICATION CHECK
    Expected compliant output:
    NoGPOListChanges : 0
#>

$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'

if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

New-ItemProperty -Path $path -Name 'NoGPOListChanges' -PropertyType DWord -Value 0 -Force | Out-Null

# Refresh policy
gpupdate /force

# Verification
Get-ItemProperty -Path $path -Name NoGPOListChanges | Select-Object NoGPOListChanges