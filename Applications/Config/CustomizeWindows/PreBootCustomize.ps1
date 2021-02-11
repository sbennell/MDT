<#	
	.NOTES
	===========================================================================
	 Created on:   	23/05/2020
	 Last Updated:  11/02/2020
	 Created by:   	Stewart Bennell
	 Filename:     	PreBootCustomize.ps1
	 Version:     	2021.14
	===========================================================================
	.DESCRIPTION
	Customizes Clean Windows 10 PreBootCustomize.

#>

$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$OSDisk = "$($tsenv.Value("OSDisk"))"
$OSDTargetSystemRoot = "$($tsenv.Value("OSDisk"))" + "\Windows"
 
#Loads the Default User Profile NTUSER.DAT file
Write-Host "Loading Default user hive..."
REG LOAD HKU\Default_User $OSDisk\Users\Default\NTUSER.DAT

#Show This PC on Desktop
Write-Output "Show This PC on Desktop"
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v  "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /v  "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

#Show User Files on Desktop
Write-Output "Show User Files on Desktop"
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v  "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /v  "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0 /f

#Show Network Icon on Desktop
Write-Output "Show User Files on Desktop"
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v  "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0 /f
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /v  "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0 /f

#Disable Autoplay for all media and devices
Write-Output "Disable Autoplay for all media and devices"
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v  "DisableAutoplay" /t REG_DWORD /d 1 /f

#Remove search bar and only show icon
Write-Output "Remove search bar and only show icon"
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v  "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f

#Disables People icon on Taskbar
Write-Output "Disables People icon on Taskbar"
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v  "PeopleBand " /t REG_DWORD /d 0 /f

#Disables Cortana Buttion
Write-Output "Disables Cortana Buttion"
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v  "ShowCortanaButton" /t REG_DWORD /d 0 /f

#Set Default Folder When Opening Explorer to This PC
Write-Output "Set Default Folder When Opening Explorer to This PC"
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v  "LaunchTo" /t REG_DWORD /d 1 /f

#Show ribbon in File Explorer when Table Mode is off
Write-Output "Show ribbon in File Explorer when Table Mode is off"
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /v  "MinimizedStateTabletModeOff" /t REG_DWORD /d 0 /f

#Show ribbon in File Explorer when Table Mode is on
Write-Output "Show ribbon in File Explorer when Table Mode is on"
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /v  "MinimizedStateTabletModeOn" /t REG_DWORD /d 0 /f

#Show known file extensions
Write-Output "Show known file extensions"
reg add "HKU\Default_User\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v  "HideFileExt" /t REG_DWORD /d 0 /f

#prevents Default the apps from redownloading. 
Write-Output "prevents Default the apps from redownloading"
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v  "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v  "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v  "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f

# Disable Bing Search in Start Menu
Write-Host "Disabling Bing Search in Start Menu..."
reg add "HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v  "BingSearchEnabled" /t REG_DWORD /d 0 /f

# Disable Sticky keys prompt
Write-Host "Disabling Sticky keys prompt..."
reg add "HKU\Default_User\Control Panel\Accessibility\StickyKeys" /v  "Flags" /t REG_EXPAND_SZ /d Flags /f

Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value Flags

#Unload the Default User Profile NTUSER.DAT file
Write-Output "Unload the Default User Profile NTUSER.DAT file"
reg unload HKU\Default_User

#Loads the Software Hive
Write-Output "Loads the Software Hive"
reg load HKLM\Default_software $OSDisk\Windows\System32\config\software

#Disable Edge autorun on Frist logon
Write-Output "Disable Edge autorun on Frist logon"
reg add "HKLM\Default_software\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v  "PreventFirstRunPage" /t REG_DWORD /d 1 /f

#Disable Acrylic Blur Effect on Sign-in Screen
Write-Output "Disable Acrylic Blur Effect on Sign-in Screen"
reg add "HKLM\Default_software\Policies\Microsoft\Windows\System" /v  "DisableAcrylicBackgroundOnLogon" /t REG_DWORD /d 1 /f

#Disabling Windows Feedback Experience program
Write-Output "Disabling Windows Feedback Experience program"
reg add "HKLM\Default_software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v  "Enabled" /t REG_DWORD /d 0 /f

#Adding Registry key to prevent bloatware apps from returning
Write-Output "Adding Registry key to prevent bloatware apps from returning"
reg add "HKLM\Default_software\Policies\Microsoft\Windows\CloudContent" /v  "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f

#Turns off Data Collection via the AllowTelemtry key by changing it to 0
Write-Output "Turns off Data Collection via the AllowTelemtry key by changing it to 0"
reg add "HKLM\Default_software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v  "AllowTelemetry" /t REG_DWORD /d 0 /f

#Turns off UAC  via the EnableLUA key by changing it to 0
Write-Output "Turns off UAC  via the EnableLUA key by changing it to 0"
reg add "HKLM\Default_software\Microsoft\Windows\CurrentVersion\Policies\System" /v  "EnableLUA" /t REG_DWORD /d 0 /f

#Unload the Software Hive
reg unload HKLM\Default_software
