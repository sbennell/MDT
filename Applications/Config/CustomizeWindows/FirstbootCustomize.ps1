<#	
	.NOTES
	===========================================================================
	 Created on:   	23/05/2020
	 Last Updated:  11/02/2020
	 Created by:   	Stewart Bennell
	 Filename:     	FirstbootCustomize.ps1
	 Version:     	2021.14
	===========================================================================
	.DESCRIPTION
	Customizes Clean Windows 10 Fristboot.
	powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File .\CustomizeWindows_WMPS.ps1

#>

$Bloatware = @(
    #Unnecessary Windows 10 AppX Apps
    "Microsoft.BingNews"
    #"Microsoft.GetHelp"
    #"Microsoft.Getstarted"
    #"Microsoft.Messaging"
    #"Microsoft.Microsoft3DViewer"
    #"Microsoft.MicrosoftOfficeHub"
    #"Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.NetworkSpeedTest"
    #"Microsoft.News"
    #"Microsoft.Office.Lens"
    "Microsoft.Office.OneNote"
    #"Microsoft.Office.Sway"
    #"Microsoft.OneConnect"
    #"Microsoft.People"
    #"Microsoft.Print3D"
    #"Microsoft.RemoteDesktop"
    #"Microsoft.SkypeApp"
    #"Microsoft.StorePurchaseApp"
    #"Microsoft.Office.Todo.List"
    #"#Microsoft.Whiteboard"
    #"Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCamera"
    #"microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    #"Microsoft.WindowsMaps"
    #"Microsoft.WindowsSoundRecorder"
    #"Microsoft.Xbox.TCUI"
    #"Microsoft.XboxApp"
    #"Microsoft.XboxGameOverlay"
    #"Microsoft.XboxIdentityProvider"
    #"Microsoft.XboxSpeechToTextOverlay"
    #"Microsoft.ZuneMusic"
    #"Microsoft.ZuneVideo"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*BubbleWitch3Saga*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    "*Spotify*"
    "*Minecraft*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*CandyCrushSaga*"
    "*FarmHeroesSaga*"
             
    #Optional: Typically not removed but you can if you need to for some reason
    #"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
    #"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
    #"*Microsoft.BingWeather*"
    #"*Microsoft.MSPaint*"
    #"*Microsoft.MicrosoftStickyNotes*"
    #"*Microsoft.Windows.Photos*"
    #"*Microsoft.WindowsCalculator*"
    #"*Microsoft.WindowsStore*"
)

foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
        Write-Output "Trying to remove $Bloat."
}

#Disables scheduled tasks that are considered unnecessary 
Write-Output "Disabling scheduled tasks"
Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask -ErrorAction SilentlyContinue


If(!(Get-AppxPackage -AllUsers | Select Microsoft.Paint3D, Microsoft.MSPaint, Microsoft.WindowsCalculator, Microsoft.WindowsStore, Microsoft.MicrosoftStickyNotes, Microsoft.WindowsSoundRecorder, Microsoft.Windows.Photos)) {

    #Credit to abulgatz for the 4 lines of code
    Get-AppxPackage -allusers Microsoft.Paint3D | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.MSPaint | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.MicrosoftStickyNotes | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.WindowsSoundRecorder | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -allusers Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} }

#Turn Off Fast Startup
Write-Output "Turn Off Fast Startup"
Set-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0

Write-Output "Finished all tasks."