<#
.SYNOPSIS
    Disables camera access from the Windows 11 lock screen to satisfy WN11-CC-000005.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : None listed in provided STIG-Implementation PDF for this STIG
    Plugin IDs      : None listed in provided STIG-Implementation PDF for this STIG
    STIG-ID         : WN11-CC-000005

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1+

.USAGE
    Run in an elevated PowerShell session.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-CC-000005).ps1

.VERIFICATION CHECK
    Expected registry path:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization

    Expected value:
    NoLockScreenCamera = 1

#>

# Ensure the registry path exists
$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

# Set the STIG-required value
New-ItemProperty -Path $Path -Name 'NoLockScreenCamera' -PropertyType DWord -Value 1 -Force | Out-Null

# Verification
Get-ItemProperty -Path $Path -Name 'NoLockScreenCamera' | Select-Object NoLockScreenCamera