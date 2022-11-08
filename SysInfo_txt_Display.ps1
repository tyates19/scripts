# This script was created on 08/09/2022 by Tanner Yates
# for the collection of Windows system data.
#
# Updated 11/8/2022 to include funny insults on $null user input

$err_mesgs = @(
			"Hmm, maybe if you speak up, I'll understand...",
			"INVALID COMMAND!!!  Just kidding...actually not really.  I really don't know what you mean...",
			"If only I could read minds, then maybe I'd understand...",
			"DOES YOUR MOTHER KNOW WHAT YOU TYPE WITH THOSE HANDS? ...because I don't.",
			"I would if I could, but I can't...",
			"The clouds in the sky are clearer than that.",
			"HOW DARE YOU?!  I mean, I have no idea what that means, but I'm sure it's terrible.",
			"DOES NOT COMPUTE!!!",
			"It can only be attributed to human error.",
			"That's something I cannot allow to happen.",
			"Sorry about this, I know it's a bit silly.",
			"Where did you learn to type?",
			"My pet ferret can type better than you!",
			"You type like i drive.",
			"Do you think like you type?",
			"Your mind just hasn't been the same since the electro-shock, has it?",
			"Maybe if you used more than just two fingers...",
			"I've seen penguins that can type better than that.",
			"You speak an infinite deal of nothing"
		)

while (1) {
    $asset = Read-Host -Prompt '
Enter Asset'
    if ( [string]::IsNullOrEmpty($asset) ) {
		Write-Output $err_mesgs[$(Get-Random -Maximum $err_mesgs.Count)]
    }
    else {
        break
    }
}
"
        Gathering data..."

sleep 2

$systemInfo_obj = @(
    new-object PSObject -Property @{"Manufacturer" = (Get-WmiObject -Class:Win32_ComputerSystem).Manufacturer; "Model" = (Get-WmiObject -Class:Win32_ComputerSystem).Model; "Hostname" = (Get-WmiObject -Class:Win32_ComputerSystem).Name; "CurrentUser" = (Get-WMIObject -Class:Win32_ComputerSystem).Username; "Domain"  = (Get-WMIObject -Class:Win32_ComputerSystem).Domain; "OS" = (Get-WMIObject -Class:win32_OperatingSystem).Caption; "Version" = (Get-WmiObject -Class:Win32_OperatingSystem).Version; "Serial" = (Get-WmiObject -Class:Win32_Bios).SerialNumber}; Get-NetIPConfiguration | Select-Object @{Name = "Interface"; Expression = {$_.InterfaceAlias}},IPv4Address | Sort-Object Interface | Format-Table; Get-NetAdapter | Select-Object @{Name = "Interface"; Expression = {$_.Name}},MacAddress | Sort-Object Interface | Format-Table
)

Write-Output "

System Info
----------"

$systemInfo_obj

Write-Output "-----BEGIN-----

ASSET
------
$asset

" > .\_$asset.txt

Write-Output "System Info
----------" >> .\_$asset.txt

$systemInfo_obj >> .\_$asset.txt

Write-Output "------END------" >> .\_$asset.txt

sleep 2

Write-Output "
	...data collected.
"

pause

$asset = $null
$err_mesgs = $null
$systemInfo_obj = $null

Exit