@Echo Off
XCOPY "%~dp0\Recovery\*.*" C:\Recovery\ /sevhky

ATTRIB -S -R -H C:\Recovery
ATTRIB -S -R -H C:\Recovery /S
icacls C:\Recovery /reset /T /C
icacls C:\Recovery /inheritance:r /grant:r SYSTEM:(OI)(CI)(F) /grant:r *S-1-5-32-544:(OI)(CI)(F) /grant:r *S-1-5-32-545:(OI)(CI)(RX) /C
ATTRIB +S +H C:\Recovery

START /WAIT "Creating Icons" "C:\Recovery\OEM\AutoIt\AutoIt3_amd64.exe" "C:\Recovery\OEM\Menu\CreateShortcut.au3" "C:\Recovery\OEM\Sysprep.cmd" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Setup Recovery.lnk" "C:\Recovery\OEM\" " " "Setup Recovery" "C:\Recovery\OEM\Menu\appicon.ico"

EXIT 0