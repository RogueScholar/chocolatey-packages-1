﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

Set-AutoUpdate -Enable

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://updates.signal.org/desktop/signal-desktop-win-7.51.0.exe'
  checksum       = 'a76cf30c03ef3c5f2c1637efc79b2cae86f605beae4e5465c4c92589fb1b9687'
  checksumType   = 'sha256'
  softwareName   = 'Signal *'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

Install-DesktopShortcut
Set-SignalOptions

Register-Application "$toolsPath\signal.bat" signal
Write-Host "Application registered as signal"

if ($pp.NoAutoUpdate) { Write-Host "Disabling auto update"; Set-AutoUpdate -Disable }
