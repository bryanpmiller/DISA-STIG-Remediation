<#
.SYNOPSIS
    Disables printing over HTTP to satisfy Windows 11 STIG WN11-CC-000110.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            :  
    Plugin IDs      : 
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : Bryan Miller
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-CC-000110).ps1 
#>

$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
$Name = 'DisableHTTPPrinting'
$DesiredValue = 1

# Ensure key exists
if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

# Read current value
$current = $null
try {
    $current = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name
}
catch {
    $current = $null
}

Write-Host "Current value: $current"

# Set compliant value
New-ItemProperty -Path $Path -Name $Name -PropertyType DWord -Value $DesiredValue -Force | Out-Null

# Verification check
$verify = (Get-ItemProperty -Path $Path -Name $Name).$Name
if ($verify -eq $DesiredValue) {
    Write-Host "Compliant. DisableHTTPPrinting is set to 1."
}
else {
    Write-Host "Remediation failed. DisableHTTPPrinting is not set to 1."
}