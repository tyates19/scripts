# This script was created on 08/09/2022 by Tanner Yates
# for the collection of Windows system data.

while (1) {
    $asset = Read-Host -Prompt '
Enter Asset'
    if ( [string]::IsNullOrEmpty($asset) ) {
        Echo "
        Uh-oh...blank input not allowed"
    } else {
        break
    }
}
"
        Gathering data..."

sleep 2

$systemInfo_obj = @(
    new-object PSObject -Property @{
        "Manufacturer"     = (Get-WmiObject -Class:Win32_ComputerSystem).Manufacturer;
        "Model"            = (Get-WmiObject -Class:Win32_ComputerSystem).Model;
        "Hostname"         = (Get-WmiObject -Class:Win32_ComputerSystem).Name;
        "CurrentUser"      = (Get-WMIObject -Class:Win32_ComputerSystem).Username;
        "Domain"           = (Get-WMIObject -Class:Win32_ComputerSystem).Domain;
        "OS"               = (Get-WMIObject -Class:win32_OperatingSystem).Caption;
        "Version"          = (Get-WmiObject -Class:Win32_OperatingSystem).Version;
        "Serial"           = (Get-WmiObject -Class:Win32_Bios).SerialNumber
    }
)

Echo "-----BEGIN-----

ASSET
------
$asset

" > .\_$asset.txt

Echo "System Info
----------" >> .\_$asset.txt

$systemInfo_obj | Format-List -Property Manufacturer,Model,Hostname,OS,Version,Serial,ProductKey,CurrentUser,Domain >> .\_$asset.txt

Get-NetIPConfiguration | Select-Object @{Name = "Interface"; Expression = {$_.InterfaceAlias}},IPv4Address | Sort Interface | Format-Table >> .\_$asset.txt

Get-NetAdapter | Select-Object @{Name = "Interface"; Expression = {$_.Name}},MacAddress | Sort Interface | Format-Table >> .\_$asset.txt

Echo "------END------" >> .\_$asset.txt

$asset = $null

Exit
