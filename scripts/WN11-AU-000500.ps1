<#
.SYNOPSIS
    Configures WN11-AU-000500 so the Application event log size is 32768 KB or greater.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-12
    Last Modified   : 2026-03-12
    Version         : 1.0
    CVEs            : None listed in uploaded STIG-Implementation PDF
    Plugin IDs      : None listed in uploaded STIG-Implementation PDF
    STIG-ID         : WN11-AU-000500

.TESTED ON
    Date(s) Tested  : 2026-03-12
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1+

.USAGE
    Run from an elevated PowerShell session.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-AU-000500).ps1
#>

$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$name = 'MaxSize'
$value = 32768

# Create the key if it does not exist
if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

# Set the required value
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null

# Verify remediation
Get-ItemProperty -Path $path -Name $name | Select-Object MaxSize