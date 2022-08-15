:: This script was created on 08/09/2022 by Tanner Yates
:: for the collection of Windows system data.
::
:: This script outputs the requested data into the CMD
:: window as well as into two(2) Text files each labeled
:: with the user indicated Asset number. One file contains
:: the System Info and the other file contains the
:: IP Config Info.
::
:: ***PLEASE NOTE: This script will only work on machines
:: with Windows 7 and above or older machines with the
:: WMIC module installed for the CMD terminal. This script
:: also may not work on Windows 10 21H1 and above. For
:: Windows 10 21H1 and above, please use the Powershell
:: script.***

@ECHO OFF

:: Prompt user for machine Asset number to be set as a
:: variable for the text file name

set /p asset=Enter the Asset Number:

:: Query system data for display in CMD window

wmic computersystem get manufacturer
wmic computersystem get model
wmic computersystem get name
wmic os get caption
wmic os get version
wmic bios get serialnumber
ipconfig /all

:: Output system data to text file

> _SYSTM_%asset%.txt (

wmic computersystem get manufacturer
wmic computersystem get model
wmic computersystem get name
wmic os get caption
wmic os get version
wmic bios get serialnumber

)

:: Output ipconfig data to text file

> _IPCNFG_%asset%.txt (

ipconfig /all

)

pause

:: Clear Asset variable set by user above

set asset=

:: Close CMD window

exit
