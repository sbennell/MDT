"%~dp0ServiceUI.exe" -process:explorer.exe "c:\Windows\System32\WindowsPowershell\v1.0\powershell.exe" -Executionpolicy bypass -file "%~dp0\Deploy-Application.ps1" -DeploymentType "Install" -DeployMode "Interactive"