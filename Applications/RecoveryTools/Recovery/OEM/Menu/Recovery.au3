#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=appicon.ico
#AutoIt3Wrapper_Outfile=RecoveryX86.exe
#AutoIt3Wrapper_Outfile_x64=RecoveryAMD64.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Recovery tools for Windows
#AutoIt3Wrapper_Res_Fileversion=5.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Anarethos - https://www.anarethos.com
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Field=ProductName|Recovery tools
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
AdlibRegister("PreventSleep",120000)

$Version = IniRead(@ScriptDir&"\Settings.ini","General","Version","0.0.0")
$Debug = IniRead(@ScriptDir&"\Settings.ini","General","Debug","0")
If $Debug = 1 Then
	$Show = @SW_SHOW
Else
	$Show = @SW_HIDE
EndIf

;Check if current local is available. If not, revert to english by default
$CurrentLanguage = RegRead("hklm\system\currentcontrolset\control\nls\language","installlanguage")
$LanguageName = IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"LanguageName","")
If $LanguageName = "" Then $CurrentLanguage = "0409"

;Display Logo
$LogoFile = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","LogoFile","Logo.jpg")
$LogoWidth = IniRead(@ScriptDir&"\Settings.ini","General","LogoWidth","400")
$LogoHeight = IniRead(@ScriptDir&"\Settings.ini","General","LogoHeight","200")
$LogoTime = IniRead(@ScriptDir&"\Settings.ini","General","LogoTime","0")
If $LogoTime>0 Then
	SplashImageOn("",$LogoFile,$LogoWidth,$LogoHeight,-1,-1,1)
	Sleep($LogoTime*1000)
	SplashOff()
EndIf

;Add-On Enabled Check
$AddOn = IniRead(@ScriptDir&"\Settings.ini","General","AddOn","0")

;Load language strings
$TextOption1Group = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption1Group","MissingString"))

$TextOption10 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption10","MissingString"))
$TextOption10Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption10Help","MissingString"))
$TextOption10Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption10Title","MissingString"))
$TextOption10Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption10Question","MissingString"))

$TextOption11 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption11","MissingString"))
$TextOption11Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption11Help","MissingString"))
$TextOption11Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption11Title","MissingString"))
$TextOption11Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption11Question","MissingString"))

$TextOption12 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption12","MissingString"))
$TextOption12Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption12Help","MissingString"))
$TextOption12Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption12Title","MissingString"))
$TextOption12Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption12Question","MissingString"))

$TextOption2Group = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption2Group","MissingString"))

$TextOption20 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption20","MissingString"))
$TextOption20Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption20Help","MissingString"))
$TextOption20Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption20Title","MissingString"))
$TextOption20Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption20Question","MissingString"))

IF ($AddOn = 1) Then
	$TextOption3Group = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption3Group","MissingString"))

	$TextOption30 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption30","MissingString"))
	$TextOption30Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption30Help","MissingString"))
	$TextOption30Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption30Title","MissingString"))
	$TextOption30Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption30Question","MissingString"))
	$TextOption30Path = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption30Path",""))

	$TextOption31 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption31","MissingString"))
	$TextOption31Help = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption31Help","MissingString"))
	$TextOption31Title = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption31Title","MissingString"))
	$TextOption31Question = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption31Question","MissingString"))
	$TextOption31Path = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOption31Path",""))
EndIF


;Menu declaration
If ($AddOn = 1) Then
	$MainMenu = GuiCreate("Recovery Tools - Version "&$Version,590,400)
Else
	$MainMenu = GuiCreate("Recovery Tools - Version "&$Version,590,270)
EndIF

$Option1Group = GUICtrlCreateGroup($TextOption1Group,10,10,570,170)
$Option2Group = GUICtrlCreateGroup($TextOption2Group,10,190,570,70)
IF ($AddOn =1) Then $Option3Group = GUICtrlCreateGroup($TextOption3Group,10,270,570,120)

GUIStartGroup()
$Option10Button = GUICtrlCreateButton("",20,30,40,40,$BS_BITMAP)
$Option10 = GUICtrlCreateLabel($TextOption10,80,45,400)
$Option10Help = $TextOption10Help
$Option11Button = GUICtrlCreateButton("",20,80,40,40,$BS_BITMAP)
$Option11 = GUICtrlCreateLabel($TextOption11,80,95,400)
$Option11Help = $TextOption11Help
$Option12Button = GUICtrlCreateButton("",20,130,40,40,$BS_BITMAP)
$Option12 = GUICtrlCreateLabel($TextOption12,80,145,400)
$Option12Help = $TextOption12Help
$Option20Button = GUICtrlCreateButton("",20,210,40,40,$BS_BITMAP)
$Option20 = GUICtrlCreateLabel($TextOption20,80,225,400)
$Option20Help = $TextOption20Help
$HelpButton = GUICtrlCreateButton("",540,35,30,30,$BS_BITMAP)
IF ($Addon = 1) Then
	$Option30Button = GUICtrlCreateButton("",20,290,40,40,$BS_BITMAP)
	$Option30 = GUICtrlCreateLabel($TextOption30,80,305,400)
	$Option30Help = $TextOption30Help
	$Option31Button = GUICtrlCreateButton("",20,340,40,40,$BS_BITMAP)
	$Option31 = GUICtrlCreateLabel($TextOption31,80,355,400)
	$Option31Help = $TextOption31Help
EndIf


;Show menu
$current = -1
$BGcolor = IniRead(@ScriptDir&"\Settings.ini","General","BgColor","0xa349a4")
$FontSize = IniRead(@ScriptDir&"\Settings.ini","General","FontSize","8.5")
$FontSizeGroup = IniRead(@ScriptDir&"\Settings.ini","General","FontSizeGroup","8.5")
$FontColor = IniRead(@ScriptDir&"\Settings.ini","General","FontColor","0x000000")
$Image1 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","Image1","1.bmp")
$Image2 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","Image2","2.bmp")
$Image3 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","Image3","3.bmp")
$Image4 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","Image4","4.bmp")
$ImageHelp = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","ImageHelp","Help.bmp")
$HTMLManual = IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"HTMLManual","english.html")
GUISetBkColor($BgColor)
GUICtrlSetFont($Option1Group,$FontSizeGroup)
GUICtrlSetFont($Option2Group,$FontSizeGroup)
GUICtrlSetFont($Option10,$FontSize)
GUICtrlSetFont($Option11,$FontSize)
GUICtrlSetFont($Option12,$FontSize)
GUICtrlSetFont($Option20,$FontSize)
GUICtrlSetImage($Option10Button,$Image1)
GUICtrlSetImage($Option11Button,$Image2)
GUICtrlSetImage($Option12Button,$Image3)
GUICtrlSetImage($Option20Button,$Image4)
GUICtrlSetImage($HelpButton,$ImageHelp)
GUICtrlSetColor($Option10,$FontColor)
GUICtrlSetColor($Option11,$FontColor)
GUICtrlSetColor($Option12,$FontColor)
GUICtrlSetColor($Option20,$FontColor)
IF ($AddOn = 1 ) Then
	$Image5 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","Image5","5.bmp")
	$Image6 = @ScriptDir&"\"&IniRead(@ScriptDir&"\Settings.ini","General","Image6","6.bmp")
	GUICtrlSetFont($Option3Group,$FontSizeGroup)
	GUICtrlSetFont($Option30,$FontSize)
	GUICtrlSetFont($Option31,$FontSize)
	GUICtrlSetImage($Option30Button,$Image5)
	GUICtrlSetImage($Option31Button,$Image6)
	GUICtrlSetColor($Option30,$FontColor)
	GUICtrlSetColor($Option31,$FontColor)
EndIf
GUISetIcon(@ScriptDir&"\appicon.ico")
GUISetState()

;Main menu function - Loop
While 1
	;This section detect the object that the mouse is pointing to show ToolTip informations
	$mouse = GUIGetCursorInfo()
	If @error<>1 Then
		If $mouse[4] = $Option10Button AND $current<>$Option10Button Then
			ToolTip("")
			ToolTip($Option10Help)
			$current = $Option10Button
		EndIf

		If $mouse[4] = $Option11Button AND $current<>$Option11Button Then
			ToolTip("")
			ToolTip($Option11Help)
			$current = $Option11Button
		EndIf

		If $mouse[4] = $Option12Button AND $current<>$Option12Button Then
			ToolTip("")
			ToolTip($Option12Help)
			$current = $Option12Button
		EndIf

		If $mouse[4] = $Option20Button AND $current<>$Option20Button Then
			ToolTip("")
			ToolTip($Option20Help)
			$current = $Option20Button
		EndIf

		If ($AddOn = 1) Then
			If $mouse[4] = $Option30Button AND $current<>$Option30Button Then
				ToolTip("")
				ToolTip($Option30Help)
				$current = $Option30Button
			EndIf

			If $mouse[4] = $Option31Button AND $current<>$Option31Button Then
				ToolTip("")
				ToolTip($Option31Help)
				$current = $Option31Button
			EndIf
		EndIf

		If $mouse[4] = 0 Then
			ToolTip("")
			$current = -1
		EndIf
	Else
		ToolTip("")
	EndIf

	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then Exit

	If $msg = $Option10Button Then ;Launching the WinRE Environment
		ToolTip("")
		$Ans = MsgBox(4+32+256+4096,$TextOption10Title,$TextOption10Question)
		If $Ans = 6 Then
			GUISetState(@SW_HIDE)
			Run("C:\Recovery\OEM\Scripts\BootToWinRe.cmd","C:\Recovery\OEM\Scripts\",$Show)
			Exit(0)
		EndIf
	EndIf

	If $msg = $Option11Button Then ;Launching the Recovery Media Creator
		ToolTip("")
		$Ans = MsgBox(4+32+256+4096,$TextOption11Title,$TextOption11Question)
		If $Ans = 6 Then
			GUISetState(@SW_HIDE)
			MediaCreator()
			GUISetState(@SW_SHOW)
		EndIf
	EndIf

	If $msg = $Option12Button Then ;Launching the System Restore Point
		ToolTip("")
		$Ans = MsgBox(4+32+256+4096,$TextOption12Title,$TextOption12Question)
		If $Ans = 6 Then
			Run("C:\Windows\System32\rstrui.exe","C:\Windows\System32")
		EndIf
	EndIf

	If $msg = $Option20Button Then ;Launching file history
		ToolTip("")
		$Ans = MsgBox(4+32+256+4096,$TextOption20Title,$TextOption20Question)
		If $Ans = 6 Then
			ShellExecute("::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{F6B6E965-E9B2-444B-9286-10C9152EDBC5}")
		EndIf
	EndIf

	If ($AddOn = 1) Then ;Launching Add-On #1
		If $msg = $Option30Button Then
			ToolTip("")
			$Ans = MsgBox(4+32+256+4096,$TextOption30Title,$TextOption30Question)
			If $Ans = 6 Then
				Run($TextOption30Path)
			EndIf
		EndIf

		If $msg = $Option31Button Then ;Launching Add-on #2
			ToolTip("")
			$Ans = MsgBox(4+32+256+4096,$TextOption31Title,$TextOption31Question)
			If $Ans = 6 Then
				Run($TextOption31Path)
			EndIf
		EndIf

		If $msg = $HelpButton Then ;Launch the instruction manual
			ToolTip("")
			ShellExecute(@ScriptDir&"\Manual\"&$HTMLManual,@ScriptDir&"\Manual")
		EndIF
	EndIf
Wend


;###################################################
;###################################################
Func MediaCreator() ;Function for the Media Creator
	If FileExists("C:\Recovery\OEM\Image\Install.wim") OR FileExists("C:\Recovery\OEM\Image\Install.swm") Then
		$TextOptionUsbGroup = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbGroup","MissingString"))
		$TextOptionUsbLine1 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbLine1","MissingString"))
		$TextOptionUsbLine2 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbLine2","MissingString"))
		$TextOptionUsbLine3 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbLine3","MissingString"))
		$TextOptionUsbLine4 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbLine4","MissingString"))
		$TextUsbCreatorStep1 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextUsbCreatorStep1","MissingString"))
		$TextUsbCreatorStep2 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextUsbCreatorStep2","MissingString"))
		$TextUsbCreatorStep3 = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextUsbCreatorStep3","MissingString"))
		$TextUsbCreatorStepError = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextUsbCreatorStepError","MissingString"))
		$TextUsbCreatorStepWaiting = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextUsbCreatorStepWaiting","MissingString"))
		$TextOptionUsbSpaceTitle = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbSpaceTitle","MissingString"))
		$TextOptionUsbSpace = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbSpace","MissingString"))
		$TextOptionUsbUnit = SplitString(IniRead(@ScriptDir&"\Settings.ini",$CurrentLanguage,"TextOptionUsbUnit","MissingString"))
		$UsbMenu = GUICreate("Recovery Tools",590,230)
		$OptionUsbGroup = GUICtrlCreateGroup($TextOptionUsbGroup,10,10,570,210)
		$OptionUsbLine1 = GUICtrlCreateLabel($TextOptionUsbLine1,20,30,550,-1,$SS_CENTER)
		$OptionUsbLine2 = GUICtrlCreateLabel($TextOptionUsbLine2,20,60,550,-1,$SS_CENTER)
		$OptionUsbLine3 = GUICtrlCreateLabel($TextOptionUsbLine3,20,90,550,-1,$SS_CENTER)
		$OptionUsbLine4 = GUICtrlCreateLabel($TextOptionUsbLine4,20,120,550,-1,$SS_CENTER)
		$UsbButton = GUICtrlCreatebutton("OK",265,180,60)
		GUICtrlSetColor($OptionUsbLine1,$FontColor)
		GUICtrlSetColor($OptionUsbLine2,$FontColor)
		GUICtrlSetColor($OptionUsbLine3,$FontColor)
		GUICtrlSetColor($OptionUsbLine4,$FontColor)
		GUICtrlSetFont($OptionUsbLine1,$FontSize)
		GUICtrlSetFont($OptionUsbLine2,$FontSize)
		GUICtrlSetFont($OptionUsbLine3,$FontSize)
		GUICtrlSetFont($OptionUsbLine4,$FontSize)
		GUICtrlSetFont($OptionUsbGroup,$FontSizeGroup)
		GUISetBkColor($BgColor,$UsbMenu)

		$DriveCombo = GUICtrlCreateCombo("", 95, 150,400)
		;WMI Object for Query
		$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")

		;WMI Query for Drive number, Make/Model and Size
		$WMIQuery = $objWMIService.ExecQuery("SELECT * FROM Win32_DiskDrive")
		$WMIQuerySize = 0
		For $obj in $WMIQuery
			$WMIQuerySize = $WMIQuerySize + 1
		Next

		;WMI Query for partition/volume per drive
		$WMIQuery2 = $objWMIService.ExecQuery("SELECT * FROM Win32_LogicalDiskToPartition")
		$WMIQuery2Size = 0
		For $obj in $WMIQuery2
			$WMIQuery2Size = $WMIQuery2Size + 1
		Next

		;Array containing all informations
		;$DriveArray[DriveID][0] = Name
		;$DriveArray[DriveID][1] = Total Size
		;$DriveArray[DriveID][2] = Partitions and drive mapping (in format PARTITION/VOLUME_LETTER with ; as separator)
		;$DriveArray[DriveID][3] = Drive mapping only (with ; as separator)
		;$DriveArray[DriveID][4] = Removable - True or False (False means cannot be used with drive creator)
		;$DriveArray[DriveID][5] = Caption text for drive selector
		Local $DriveArray[$WMIQuerySize][6]
		For $i=0 to UBound($DriveArray)-1
			$DriveArray[$i][2] = ""
			$DriveArray[$i][3] = ""
			$DriveArray[$i][4] = False
		Next

		;Get Drive number, model, size
		For $obj In $WMIQuery
			$DriveNumber = StringTrimLeft($Obj.DeviceID,17)
			$Model = $Obj.Model
			$Size = Round($Obj.Size/1024/1024/1024,2)
			;IF ($Size >0) Then MsgBox(0, "Drive #" & $DriveNumber, "Drive number : " & $DriveNumber & @CRLF & "Make/Model : " & $Model & @CRLF & "Size in GB : " & $Size)
			$DriveArray[$DriveNumber][0] = $Model
			$DriveArray[$DriveNumber][1] = $Size
		Next


		;Get drive number, partition and drive/letter mapping
		$WMIQuery2 = $objWMIService.ExecQuery("SELECT * FROM Win32_LogicalDiskToPartition")
		For $obj In $WMIQuery2
			$sAntecedent = $obj.Antecedent
			$sDependent = $obj.Dependent
			$iSplit = StringSplit(StringReplace(StringReplace(StringMid($sAntecedent,StringInStr($sAntecedent, "Disk #")),"""","")," ",""),",")
			$iDisk = StringReplace($iSplit[1],"Disk#","")
			$iPartition = StringReplace($iSplit[2],"Partition#","")
			$sDrive = StringMid($sDependent, StringInStr($sDependent, 'DeviceID="') + 10, 1)
			;MsgBox(0, $sDrive & " Drive", $sDrive & " Drive is on Disk #" & $iDisk  & ", partition #" & $iPartition)
			$DriveArray[$iDisk][2] = $DriveArray[$iDisk][2] & $iPartition & "/" & $sDrive & ";"
			$DriveArray[$iDisk][3] = $DriveArray[$iDisk][3] & $sDrive & ";"
		Next

		;Identifying removable drive
		$RemovableDrive = DriveGetDrive($DT_REMOVABLE)
		If Not @Error Then
			For $i=1 to $RemovableDrive[0]
				$DriveLetter =StringUpper(StringTrimRight($RemovableDrive[$i],1))
				For $j=0 to UBound($DriveArray)-1
					IF StringInStr($DriveArray[$j][3],$Driveletter) Then
						$DriveArray[$j][4] = True
					EndIf
				Next
			Next
		EndIf

		;Creating caption for drive selector
		For $i=0 to UBound($DriveArray)-1
			$Str = "Drive #" & $i
			$Str = $Str & " - "
			$Str = $Str & $DriveArray[$i][0]
			$Str = $Str & " - "
			$Str = $Str & $DriveArray[$i][1] & " GB"
			$Str = $Str & " - "
			$Str = $Str & "Volume(s) " & $DriveArray[$i][3]
			$Str = StringTrimRight($Str,1)
			$DriveArray[$i][5] = $Str
		Next


		$DriveListCombo=""
		For $i=0 to UBound($DriveArray)-1
			If $DriveArray[$i][4] == True Then
				$Str= "Drive Number: " & $i & @CRLF
				$Str = $Str & "Drive Name: " & $DriveArray[$i][0] & @CRLF
				$Str = $Str & "Total Size: " & $DriveArray[$i][1] & @CRLF
				$Str = $Str & "Mappings (Full Info): " & $DriveArray[$i][2] & @CRLF
				$Str = $Str & "Mappings (Short): " & $DriveArray[$i][3] & @CRLF
				$Str = $Str & "Removable: " & $DriveArray[$i][4] & @CRLF
				$Str = $Str & "Caption: " & $DriveArray[$i][5]
				;MsgBox(0,"Drive Info",$Str)
				$DriveListCombo=$DriveListCombo & $DriveArray[$i][5] & "|"
			EndIf
		Next
		;MsgBox(0,"Drive List Combo",$DriveListCombo)

		GuiCtrlSetData($DriveCombo,$DriveListCombo,"")
		GUISetState(@SW_SHOW,$UsbMenu)

		While 1
			$msgUsb = GUIGetMsg()
			If $msgUsb = $GUI_EVENT_CLOSE Then
				GuiDelete($UsbMenu)
				Return
			EndIf

			If $msgUsb = $UsbButton Then
				GUISetState(@SW_HIDE,$UsbMenu)
				$Destination = -1
				$Choice = GuiCtrlRead($DriveCombo)
				If $Choice = "" Then ExitLoop
				For $i=0 to UBound($DriveArray)-1
					If $DriveArray[$i][5] == $Choice Then
						$Destination = $i
					EndIf
				Next

				$Size=DirGetSize("C:\Recovery\OEM\Image")
				$Size = ($Size/1024/1024/1024) + 0.5
				$SizeUsb=$DriveArray[$Destination][1]


				If $SizeUsb<$Size Then
					MsgBox(0+16,$TextOptionUsbSpaceTitle,$TextOptionUsbSpace & " " & Round($Size) & " " & $TextOptionUsbUnit)
					GuiDelete($UsbMenu)
					Return
				EndIF


				ProgressOn("Recovery Tools",$TextUsbCreatorStepWaiting,$TextUsbCreatorStep1,-1,-1,2+16)
				$Result = RunWait("C:\Recovery\OEM\Scripts\RecoveryDrive01Prepare.cmd" & " " & $Destination,"C:\Recovery\OEM\Scripts",$Show)
				If $Result<>0 Then
					MsgBox(4096+16,"",$TextUsbCreatorStepError & "Code : " & $Result)
					ProgressOff()
					GuiDelete($UsbMenu)
					Return
				EndIF

				ProgressSet(33,$TextUsbCreatorStep2)
				$Result = RunWait("C:\Recovery\OEM\Scripts\RecoveryDrive02CopyTools.cmd","C:\Recovery\OEM\Scripts",$Show)
				If $Result<>0 Then
					MsgBox(4096+16,"",$TextUsbCreatorStepError & "Code : " & $Result)
					ProgressOff()
					GuiDelete($UsbMenu)
					Return
				EndIF

				ProgressSet(66,$TextUsbCreatorStep3)
				$Result = RunWait("C:\Recovery\OEM\Scripts\RecoveryDrive03CopyImage.cmd","C:\Recovery\OEM\Scripts",$Show)
				If $Result<>0 Then
					MsgBox(4096+16,"",$TextUsbCreatorStepError & "Code : " & $Result)
					ProgressOff()
					GuiDelete($UsbMenu)
					Return
				EndIF

				ProgressSet(100,"")
				ProgressOff()

				GuiDelete($UsbMenu)
				Return
			EndIF
		Wend
	Else
		RunWait("C:\Windows\System32\RecoveryDrive.exe","C:\Windows\System32")
		Return
	EndIf
	Return
EndFunc

;#######################################################
;#######################################################
func SplitString($Input) ;Function to split string from the INI file by using ;
	Return StringReplace($Input,";",@CRLF)
endFunc

;#######################################################
;#######################################################
Func PreventSleep() ;Function to prevent the computer from going to sleep (simulate mouse move)
	$Current = MouseGetPos()
	MouseMove(5,5,0)
	MouseMove($Current[0],$Current[1],0)
EndFunc