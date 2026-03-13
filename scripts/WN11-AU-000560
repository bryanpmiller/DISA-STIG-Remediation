<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-12
    Last Modified   : 2026-03-12
    Version         : 1.0
    CVEs            :  
    Plugin IDs      : 
    STIG-ID         : WN11-AU-000560

.TESTED ON
    Date(s) Tested  : 
    Tested By       : Bryan Miller
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(<STIG ID>).ps1 
#>

# Verify current setting
Write-Host "Current setting:"
auditpol /get /subcategory:"Other Logon/Logoff Events"

# Enable Success auditing for the subcategory
auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable

# Re-verify
Write-Host "`nUpdated setting:"
auditpol /get /subcategory:"Other Logon/Logoff Events"
