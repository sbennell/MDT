@Echo Off
%~d0%
CD "%~dp0%"
CLS

ECHO *****************************
ECHO Marking updates as permanent
ECHO *****************************
DISM.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase


ECHO *****************************
ECHO Capturing softwares
ECHO *****************************
C:
CD \
CD Recovery
CD OEM
CD ScanState
CD %PROCESSOR_ARCHITECTURE%
scanstate.exe /apps /config:C:\Recovery\OEM\ScanState\%PROCESSOR_ARCHITECTURE%\Config_AppsAndSettings.xml /ppkg C:\Recovery\Customizations\Recovery.ppkg /o /c /v:13 /l:C:\Recovery\OEM\Logs\ScanState.log
CD ..
CD ..
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
START /WAIT C:\Windows\System32\Sysprep\SysPrep.exe /generalize /oobe /quit /unattend:C:\Recovery\OEM\XML\UnAttend.%PROCESSOR_ARCHITECTURE%.Xml
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


ECHO %DATE%-%TIME%-Rebooting >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO *****************************
ECHO Computer will shutdown
ECHO *****************************
SHUTDOWN -S -T 60
EXIT 0