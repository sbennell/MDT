@Echo Off
%~d0%
CD "%~dp0%"
CLS
ECHO *************************************
ECHO Testing ADMIN rights
ECHO *************************************
ECHO Test>C:\AdminTest.txt
IF NOT EXIST C:\AdminTest.txt (
ECHO *************************************
ECHO Error!
ECHO *************************************
ECHO Please run this script with 
ECHO administrator access!
ECHO *************************************
PAUSE
EXIT
)
DEL C:\AdminTest.txt

CLS
ECHO *****************************
ECHO Finding OS Drive and partition
ECHO *****************************
SET OSDRV=-1
wmic path win32_bootconfiguration get caption /value |find /i "caption" > "%temp%\wmic_output.txt"
FOR /F "tokens=1,2,3,4,* delims=\" %%I in (%temp%\wmic_output.txt) do @SET OSDRV=%%K
DEL "%temp%\wmic_output.txt"
SET OSDRV=%OSDRV:~8%
IF "%OSDRV%"=="-1" GOTO BOOTDRIVERROR
ECHO Windows is on DISK %OSDRV%


ECHO %DATE%-%TIME%-WinREUpdate-Start >>C:\Recovery\OEM\Logs\Logfile.txt
ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
MD C:\Recovery\OEM\Temp\
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
IF NOT EXIST C:\Recovery\OEM\ResetConfig.xml GOTO MISSINGFILES


ECHO ****************************
ECHO Mounting Recovery Partition
ECHO ****************************
TYPE C:\Recovery\OEM\ResetConfig.xml | find /i "WindowsREPartition" >C:\Recovery\OEM\Temp\FindRecovery.txt
FOR /f "delims=>< tokens=3" %%I in (C:\Recovery\OEM\Temp\FindRecovery.txt) do SET VOL=%%I
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
ECHO SELECT DISK %OSDRV% >C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO SELECT PARTITION %VOL% >>C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO ASSIGN LETTER R >>C:\Recovery\OEM\Temp\MountRecovery.txt
ECHO SELECT DISK %OSDRV% >C:\Recovery\OEM\Temp\UnMountRecovery.txt
ECHO SELECT PARTITION %VOL% >>C:\Recovery\OEM\Temp\UnMountRecovery.txt
ECHO REMOVE >>C:\Recovery\OEM\Temp\UnMountRecovery.txt
DISKPART /S C:\Recovery\OEM\Temp\MountRecovery.txt


ECHO ****************************
ECHO Mounting WINRE
ECHO ****************************
MD C:\Recovery\OEM\Mount
DISM /Mount-Wim /WimFile:R:\Recovery\WindowsRE\WinRE.wim /Index:1 /MountDir:C:\Recovery\OEM\Mount


ECHO ****************************
ECHO Updating WINRE
ECHO ****************************
ATTRIB -S -R -H C:\Recovery\OEM\WinREFiles\*.* /S
ATTRIB -S -R -H C:\Recovery\OEM\Mount\sources\recovery\tools\*.* /s
RD /S /Q C:\Recovery\OEM\Mount\sources\recovery\tools
IF EXIST "C:\Program Files (x86)" XCOPY C:\Recovery\OEM\WinREFiles\amd64\*.* C:\Recovery\OEM\Mount\ /SEVHKXOY
IF NOT EXIST "C:\Program Files (x86)" XCOPY C:\Recovery\OEM\WinREFiles\x86\*.* C:\Recovery\OEM\Mount\ /SEVHKXOY

ECHO ****************************
ECHO Unmounting WINRE
ECHO ****************************
DISM /UnMount-Wim /MountDir:C:\Recovery\OEM\Mount /Commit
RD C:\Recovery\OEM\Mount


ECHO ******************************
ECHO Unmounting Recovery Partition
ECHO ******************************
DISKPART /S C:\Recovery\OEM\Temp\UnmountRecovery.txt


ECHO ******************************
ECHO Enabling tools
ECHO ******************************
ReAgentc.exe /SetBootShellLink /ConfigFile C:\Recovery\OEM\XML\WinRE.xml


ECHO ************************
ECHO Cleaning Old Files
ECHO ************************
DEL C:\Recovery\OEM\Temp\FindRecovery.txt
DEL C:\Recovery\OEM\Temp\MountRecovery.txt
DEL C:\Recovery\OEM\Temp\UnmountRecovery.txt
RD C:\Recovery\OEM\Temp\
ECHO %DATE%-%TIME%-WinREUpdate-End >>C:\Recovery\OEM\Logs\Logfile.txt
EXIT 0


:MISSINGFILES
ECHO ***********************************
ECHO Missing ResetConfig.xml
ECHO Process aborted!
ECHO ***********************************
ECHO %DATE%-%TIME%-WinREUpdate-Error-MissingFiles >>C:\Recovery\OEM\Logs\Logfile.txt
TIMEOUT 10
EXIT 1

:BOOTDRIVERROR
ECHO *****************************
ECHO Missing files
ECHO *****************************
ECHO Cannot identify OS partition
ECHO and disk.
ECHO %DATE%-%TIME%-WinREUpdate-Error-NoBootDriveFound >>C:\Recovery\OEM\Logs\Logfile.txt
TIMEOUT 10
EXIT 1