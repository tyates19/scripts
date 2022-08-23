@ECHO OFF

wmic computersystem get manufacturer
wmic computersystem get model
wmic computersystem get name
wmic os get caption
wmic os get version
wmic bios get serialnumber
ipconfig /all

pause

exit