#Version 2021.3
#Stewart Bennell 12/01/2021
#Bennell IT

$ChocoPackage = "libreoffice-still"
$FallbackVer = "7.0.2"
$Params = '""'


# Check if Chocolatey is installed and if not, install it.
If ( get-command -Name choco.exe -ErrorAction SilentlyContinue ){
    $ChocoExe = "choco.exe"
} elseif (test-path -Path (Join-Path -path $Env:ALLUSERSPROFILE -ChildPath "Chocolatey\bin\choco.exe")) {
    $ChocoExe = Join-Path -path $Env:ALLUSERSPROFILE -ChildPath "Chocolatey\bin\choco.exe"
} else {
    try {
        write-output "Starting to install chocolatey...."
        Invoke-Expression ((New-Object -TypeName net.webclient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction Stop
        choco feature enable -n allowGlobalConfirmation
        $ChocoExe = Join-Path -path $Env:ALLUSERSPROFILE -ChildPath "Chocolatey\bin\choco.exe"
    }
    catch {
        Throw "Failed to install Chocolatey"
    } 
}

If ($ChocoExe){
	write-output "Starting to install $ChocoPackage"
	start-process -WindowStyle hidden -FilePath $ChocoExe -ArgumentList "upgrade $ChocoPackage --force --confirm --install-if-not-installed -params $Params" -Wait
	If((& $ChocoExe list "$ChocoPackage" -li --limit-output --exact) -like "$ChocoPackage*"){
		write-host "Installed"
	} else {
		write-output "Fqailed to install $ChocoPackage Going install $ChocoPackage With fallback Version"
		start-process -WindowStyle hidden -FilePath $ChocoExe -ArgumentList "upgrade $ChocoPackage --version=$FallbackVer --force --confirm --install-if-not-installed -params $Params" -Wait
		If((& $ChocoExe list "$ChocoPackage" -li --limit-output --exact) -like "$ChocoPackage*"){write-host "Installed With Fallback Version"}
		} 
}else {
    throw 'Could not find choco.exe'
    Exit 666
}

If(Test-Path -Path "C:\Users\Public\Desktop\LibreOffice*.lnk") {Remove-Item -Path "C:\Users\Public\Desktop\LibreOffice*.lnk" -Force}

$Filename = Get-Item 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\LibreOffice*'
If(Test-Path -Path $Filename\LibreOffice*.lnk) {Rename-Item $Filename -NewName LibreOffice}	
			