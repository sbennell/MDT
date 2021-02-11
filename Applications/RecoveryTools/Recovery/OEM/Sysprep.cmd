@Echo Off
CLS
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

%~d0%
CD "%~dp0%"
CLS
ECHO *****************************
ECHO turn UAC on again 
ECHO *****************************
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

ECHO *****************************
ECHO Removing startup Scrit
ECHO *****************************
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Setup Recovery.lnk"

ECHO *****************************
ECHO Marking updates as permanent
ECHO *****************************
DISM.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase

ECHO *****************************
ECHO Capturing softwares
ECHO *****************************
C:/Recovery\OEM/ScanState/scanstate.exe /apps /config:C:\Recovery\OEM\ScanState\Config_AppsAndSettings.xml /ppkg C:\Recovery\Customizations\Recovery.ppkg /o /c /v:13 /l:C:\Recovery\OEM\Logs\ScanState.log

IF NOT EXIST C:\Recovery\Customizations\Recovery.ppkg (
ECHO.
ECHO ********************************
ECHO Error!
ECHO ScanState failed!
ECHO Process abborted!
ECHO ********************************
ECHO %DATE%-%TIME%-Sysprep-Error >>C:\Recovery\OEM\Logs\Logfile.txt
PAUSE
EXIT 1
)

ECHO %DATE%-%TIME%-Push-Button option selected (no full image) >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Enabling WinRE
ECHO ************************
REAGENTC /ENABLE /AUDITMODE

ECHO %DATE%-%TIME%-Running sysprep >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Running Sysprep
ECHO *****************************
TASKKILL /IM SYSPREP.EXE /F /T
TASKKILL /IM WMPNETWK.EXE /F /T
START /WAIT C:\Windows\System32\Sysprep\SysPrep.exe /generalize /oobe /quit /unattend:C:\Recovery\OEM\XML\UnAttend.Xml
ECHO %DATE%-%TIME%-Sysprep-End >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO Do not delete! >Find.Me


ECHO %DATE%-%TIME%-Cleaning old files >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
RD /S /Q C:\Recovery\OEM\Temp\
RD /S /Q C:\Recovery\OEM\ScanState


ECHO %DATE%-%TIME%-Rebooting >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Computer will shutdown
ECHO *****************************
SHUTDOWN -S -T 60
EXIT 0