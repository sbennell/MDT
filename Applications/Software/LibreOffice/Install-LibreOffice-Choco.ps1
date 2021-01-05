#Version 2021.2
#Stewart Bennell 5/01/2021
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
	start-process -WindowStyle hidden -FilePath $ChocoExe -ArgumentList "upgrade $ChocoPackage --force --confirm --install-if-not-installed -params $Params" -Wait
	If((& $ChocoExe list "$ChocoPackage" -li --limit-output --exact) -like "$ChocoPackage*"){
		write-host "Installed"
	} else {
		start-process -WindowStyle hidden -FilePath $ChocoExe -ArgumentList "upgrade $ChocoPackage --version=$FallbackVer --force --confirm --install-if-not-installed -params $Params" -Wait
		If((& $ChocoExe list "$ChocoPackage" -li --limit-output --exact) -like "$ChocoPackage*"){write-host "Installed With Fallback Version"}
		} 
}else {
    throw 'Could not find choco.exe'
    Exit 666
}


If(Test-Path -Path "C:\Users\Public\Desktop\LibreOffice*.lnk") {Remove-Item -Path "C:\Users\Public\Desktop\LibreOffice*.lnk" -Force}
