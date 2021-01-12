#Bennell IT OEM Info
#Version 2021.1.1
#Stewart Bennell 12/01/2021


copy-item $PSScriptRoot\OEMlogo.bmp "c:\windows\system32"
copy-item $PSScriptRoot\OEMLogo.BMP "c:\windows\system32\oobe\info\"
copy-item "$PSScriptRoot\" "C:\Program Files\bennellit\"

# make required registry changes
$strPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation"

Set-ItemProperty -Path $strPath -Name Logo -Value "C:\Windows\System32\OEMlogo.bmp"
Set-ItemProperty -Path $strPath -Name Manufacturer -Value "Bennell IT"
Set-ItemProperty -Path $strPath -Name SupportURL -Value https://www.bennellit.com.au

write-host "End of Script"

