<#
.SYNOPSIS
    Remediates WN11-00-000210 by disabling bluetooth

.NOTES
    Author          : Bryan Miller
    LinkedIn        : linkedin.com/in/bryan-p-miller/
    GitHub          : github.com/bryanpmiller
    Date Created    : 2026-03-13
    Last Modified   : 2026-03-13
    Version         : 1.1
    CVEs            : None listed in the provided STIG-Implementation PDF
    Plugin IDs      : None listed in the provided STIG-Implementation PDF
    STIG-ID         : WN11-00-000210

.TESTED ON
    Date(s) Tested  : 2026-03-13
    Tested By       : Bryan Miller
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1+

.USAGE
    Run from an elevated PowerShell session on systems where Bluetooth is not approved.
    Example syntax:
    PS C:\> .\__remediation_template(WN11-00-000210).ps1

.VERIFICATION CHECK
    Expected output from #Verification:
    No Bluetooth devices with Status = OK,
    or no Bluetooth hardware present.

#>
Write-Host "==== WN11-00-000210 Bluetooth Remediation ===="

#################################################
# Disable Bluetooth Devices
#################################################

$BluetoothDevices = Get-PnpDevice -Class Bluetooth -ErrorAction SilentlyContinue

if ($BluetoothDevices) {

    Write-Host "`nDisabling Bluetooth devices..."

    foreach ($Device in $BluetoothDevices) {
        try {
            Disable-PnpDevice -InstanceId $Device.InstanceId -Confirm:$false -ErrorAction Stop
            Write-Host "Disabled device: $($Device.FriendlyName)"
        }
        catch {
            Write-Warning "Failed to disable device: $($Device.FriendlyName)"
        }
    }

}
else {
    Write-Host "No Bluetooth devices detected."
}

#################################################
# Disable Bluetooth Services
#################################################

$BluetoothServices = @(
    "bthserv",        # Bluetooth Support Service
    "BluetoothUserService"
)

Write-Host "`nDisabling Bluetooth services..."

foreach ($Service in $BluetoothServices) {

    $svc = Get-Service -Name $Service -ErrorAction SilentlyContinue

    if ($svc) {

        if ($svc.Status -ne "Stopped") {
            Stop-Service $Service -Force
            Write-Host "Stopped service: $Service"
        }

        Set-Service $Service -StartupType Disabled
        Write-Host "Disabled service startup: $Service"

    }
}

#################################################
# Verification
#################################################

Write-Host "`n==== Verification ===="

Write-Host "`nBluetooth Devices:"
Get-PnpDevice -Class Bluetooth -ErrorAction SilentlyContinue |
Select-Object Status, FriendlyName, InstanceId |
Format-Table -AutoSize

Write-Host "`nBluetooth Services:"
Get-Service bthserv, BluetoothUserService -ErrorAction SilentlyContinue |
Select-Object Status, Name, StartType |
Format-Table -AutoSize