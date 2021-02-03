# Install choco
Set-ExecutionPolicy Bypass -Scope Process -Force

# install chocolatey if not installed
if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
  Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install all the packages
## Browsers
choco install googlechrome -y

## Text editors / IDEs
choco install notepadplusplus -y
choco install libreoffice-fresh -y

## Office
choco feature enable -n=useRememberedArgumentsForUpgrades
choco install office365business -params '"/exclude:""Access Groove Lync OneDrive OneNote Outlook Publisher"""' -y

## Media
choco install vlc -y

## Utilities + other
choco install 7zip -y
choco install winscp -y

choco install icue
choco install vivaldi
choco install spotify
choco install geforce-experience
