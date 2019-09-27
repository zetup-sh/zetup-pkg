# install choco on windows
if (-Not (Get-Command choco -errorAction SilentlyContinue)) {
  Set-ExecutionPolicy Bypass -Scope Process -Force;  Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

zetup link "$ZETUP_CUR_PKG/shell/profile.ps1" $profile