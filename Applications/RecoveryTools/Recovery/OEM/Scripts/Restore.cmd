@Echo Off
ECHO *********************************
ECHO Finding Windows
ECHO *********************************
SET DEST=-1
FOR /D %%I in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO @IF EXIST %%I:\Recovery\OEM\Find.Me SET DEST=%%I
IF "%DEST%"=="-1" EXIT 1

ECHO *********************************
ECHO Tagging Recovery in the log file
ECHO *********************************
ECHO %DATE%-%TIME%-Recovery-Start >>%DEST%:\Recovery\OEM\Logs\Logfile.txt

ECHO *********************************
ECHO Restoring Sysprep / OOBE script
ECHO *********************************
COPY /Y %DEST%:\Recovery\OEM\XML\Unattend.%PROCESSOR_ARCHITECTURE%.xml %DEST%:\Windows\Panther\Unattend.xml

ECHO *********************************
ECHO Restoring files attributes
ECHO *********************************
ATTRIB -S -R -H %DEST%:\Recovery
ATTRIB -S -R -H %DEST%:\Recovery /S
icacls %DEST%:\Recovery /reset /T /C
icacls %DEST%:\Recovery /inheritance:r /grant:r SYSTEM:(OI)(CI)(F) /grant:r *S-1-5-32-544:(OI)(CI)(F) /grant:r *S-1-5-32-545:(OI)(CI)(RX) /C
ATTRIB +S +H %DEST%:\Recovery

ECHO %DATE%-%TIME%-Recovery-End >>%DEST%:\Recovery\OEM\Logs\Logfile.txt
EXIT 0
