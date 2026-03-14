<#
.SYNOPSIS
    Remediates WN11-EP-000310 by enabling the Kernel DMA Protection device enumeration policy and setting it to Block All.

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.0
    CVEs            : Not listed in provided STIG-Implementation PDF
    Plugin IDs      : Not listed in provided STIG-Implementation PDF
    STIG-ID         : WN11-EP-000310

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1+

.USAGE
    Run from an elevated PowerShell session.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-EP-000310).ps1

.VERIFICATION CHECK
    Expected registry path:
    HKLM:\Software\Policies\Microsoft\Windows\Kernel DMA Protection

    Expected registry value:
    DeviceEnumerationPolicy : 0

#>

$RegPath = 'HKLM:\Software\Policies\Microsoft\Windows\Kernel DMA Protection'
$ValueName = 'DeviceEnumerationPolicy'
$DesiredValue = 0

# Create the key if it does not exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Read current value if present
$current = $null
try {
    $current = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction Stop).$ValueName
}
catch {
    # Value does not exist yet
}

Write-Host "Current value: $current"

# Set required value
New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $DesiredValue -Force | Out-Null

# Verification
$verify = Get-ItemProperty -Path $RegPath -Name $ValueName
Write-Host "Verification result:"
$verify | Select-Object $ValueName