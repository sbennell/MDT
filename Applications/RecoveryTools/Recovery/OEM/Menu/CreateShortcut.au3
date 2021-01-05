#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=CreateShortcut.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Description=Tool to create a shotcut to an application
#AutoIt3Wrapper_Res_Fileversion=5.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Anarethos - https://www.anarethos.com
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Field=ProductName|Shortcut Creator for Recovery Tools
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;$CmdLine[1] = Program to run
;$CmdLine[2] = Destination path for the LNK file
;$CmdLine[3] = WorkingDir
;$CmdLine[4] = Arguments
;$CmdLine[5] = Description
;$CmdLine[6] = Icon to use
FileCreateShortcut ($CmdLine[1],$CmdLine[2],$CmdLine[3],$CmdLine[4],$CmdLine[5],$CmdLine[6])
