#Bennell IT OEM Info
#Version 2021.1.3
#Stewart Bennell 12/01/2021


copy-item $PSScriptRoot\OEMlogo.bmp  -Destination "c:\windows\system32"
copy-item "$PSScriptRoot\Bennell IT Remote Support.url"  -Destination  "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\"

# make required registry changes
$strPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation"

Set-ItemProperty -Path $strPath -Name Logo -Value "c:\windows\system32\OEMlogo.bmp"
Set-ItemProperty -Path $strPath -Name Manufacturer -Value "Bennell IT"
Set-ItemProperty -Path $strPath -Name SupportURL -Value https://www.bennellit.com.au

write-host "End of Script"