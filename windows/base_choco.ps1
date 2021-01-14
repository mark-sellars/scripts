# Install choco
Set-ExecutionPolicy Bypass -Scope Process -Force

# install chocolatey if not installed
if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
  Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install all the packages
## Browsers
choco install googlechrome -y
choco install firefox -y

## Text editors / IDEs
choco install notepadplusplus -y
choco install libreoffice-fresh -y

## Office
choco feature enable -n=useRememberedArgumentsForUpgrades
choco install office365business -params '"/exclude:""Groove Lync Publisher"""' -y
choco install office365business -y

## Visio
#choco install office365business -params  '"/productid:VisioProRetail"' -fy

## Dev tools
choco install putty -y

## Media
choco install vlc -y

## Utilities + other
choco install 7zip -y
choco install tortoisesvn -y
choco install winscp -y
choco install foxitreader -y
choco install drawio -y
choco install freecad -y

## Domain Utilities
choco install thunderbird -y
