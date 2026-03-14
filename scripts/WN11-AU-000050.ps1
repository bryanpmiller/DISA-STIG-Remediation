<#
.SYNOPSIS
    Enables Windows 11 STIG WN11-AU-000050 by auditing successful process creation events.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : None listed in provided STIG-Implementation PDF
    Plugin IDs      : None listed in provided STIG-Implementation PDF
    STIG-ID         : WN11-AU-000050

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1 / 7.x

.USAGE
    Run from an elevated PowerShell session.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-AU-000050).ps1

#>

# Enable Success auditing for Process Creation
auditpol /set /subcategory:"Process Creation" /success:enable

# Verification
auditpol /get /subcategory:"Process Creation"