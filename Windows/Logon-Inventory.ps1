<#
.SYNOPSIS
    Collects and logs device and user information to a network share during user logon.

.DESCRIPTION
    This script gathers key inventory details such as the current username, computer name, BIOS serial number, device model, and manufacturer.
    It then appends this information, along with a timestamp, to a specified log file on a network share.
    Intended for use in logon scripts to maintain an up-to-date inventory of devices and users.

.PARAMETER LogPath
    The UNC path to the network share and log file where the inventory information will be appended.

.NOTES
    Ensure the executing user has write permissions to the specified network share.
    The log file will contain comma-separated values for each logon event.

.EXAMPLE
    # Example usage in a logon script
    # (Script is executed automatically at user logon)
#>

# Define the network share and log file
$LogPath = "\\yourserver\share$\LogonInventory.txt"

# Collect information
$UserName       = $env:USERNAME
$HostName       = $env:COMPUTERNAME
$Serial         = (Get-CimInstance Win32_BIOS).SerialNumber
$Model          = (Get-CimInstance Win32_ComputerSystem).Model
$Manufacturer   = (Get-CimInstance Win32_ComputerSystem).Manufacturer
$DateTime       = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")

# Prepare log line
$LogLine = "$DateTime,$UserName,$HostName,$Manufacturer,$Model,$Serial"

# Append to log file
Add-Content -Path $LogPath -Value $LogLine
