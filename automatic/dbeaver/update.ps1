Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$repoUser = "dbeaver"
$repoName = "dbeaver"

function global:au_SearchReplace {
  return @{
    'tools\chocolateyInstall.ps1' = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\legal\VERIFICATION.txt"    = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUri)>"
      "(?i)(64-Bit.+)\<.*\>"     = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType64)"
      "(?i)(checksum64:).*"      = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate($Package) {
  $licenseData = Get-GithubRepositoryLicense $repoUser $repoName
  $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
  if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

  Invoke-WebRequest -Uri $licenseData.download_url -UseBasicParsing -OutFile "$licenseFile"
  $Latest.LicenseUrl = $licenseData.html_url

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
  Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
  Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
  $release = Get-LatestGithubReleases $repoUser $repoName $true

  $url64 = $release.latest.Assets | Where-Object { $_ -match 'x86_64-setup\.exe$' } | Select-Object -First 1

  $Latest = @{
    URL64      = $url64;
    Version    = $release.latest.Version;
    ReleaseUri = $release.latest.ReleaseUrl
  }
  return $Latest
}

update -ChecksumFor None
