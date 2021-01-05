@Echo Off
XCOPY "\\S1-MDT\MDT\Scripts\Extras\recovery\Recovery\*.*" C:\Recovery\ /sevhky
rem Robocopy \\S1-MDT\MDT\Scripts\Extras\recovery\Recovery\*.* C:\Recovery  /E

ATTRIB -S -R -H C:\Recovery
ATTRIB -S -R -H C:\Recovery /S
icacls C:\Recovery /reset /T /C
icacls C:\Recovery /inheritance:r /grant:r SYSTEM:(OI)(CI)(F) /grant:r *S-1-5-32-544:(OI)(CI)(F) /grant:r *S-1-5-32-545:(OI)(CI)(RX) /C
ATTRIB +S +H C:\Recovery

XCOPY "\\S1-MDT\MDT\Scripts\Extras\recovery\Settings\UEFI\*.*" C:\Recovery\OEM\ /sevhky

EXIT 0