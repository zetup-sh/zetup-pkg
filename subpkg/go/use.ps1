$cmdName="go"
if (-Not (Get-Command $cmdName -errorAction SilentlyContinue)) {
  if ( (Get-WMIObject Win32_OperatingSystem).OSArchitecture -eq "64-bit") {
    $ARCH="amd64"
    if ($env:GO_VERSION) {
      $VERSION=$env:GO_VERSION
    } else {
      $VERSION="1.12.9"
    }
    $OS="windows"
  }

  mkdir -p ${HOME}/go/src/github.com
  mkdir -p ${HOME}/go/src/gitlab.com
  mkdir -p "${HOME}/go/bin"


  $downloadDir = $env:TEMP
  $packageName = 'golang'
  $url32 = 'https://storage.googleapis.com/golang/go' + $version + '.windows-386.zip'
  $url64 = 'https://storage.googleapis.com/golang/go' + $version + '.windows-amd64.zip'
  $goroot = "C:\go$version"

  # Determine type of system
  if ($ENV:PROCESSOR_ARCHITECTURE -eq "AMD64") {
    $url = $url64
  } else {
    $url = $url32
  }

  if (Test-Path "$goroot\bin\go") {
    Write-Host "Go is installed to $goroot"
    exit
  }

  echo "Downloading $url"
  $zip = "$downloadDir\golang-$version.zip"
  if (!(Test-Path "$zip")) {
    $downloader = new-object System.Net.WebClient
    $downloader.DownloadFile($url, $zip)
  }

  echo "Extracting $zip to $goroot"
  if (Test-Path "$downloadDir\go") {
    rm -Force -Recurse -Path "$downloadDir\go"
  }
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [System.IO.Compression.ZipFile]::ExtractToDirectory("$zip", $downloadDir)
  mv "$downloadDir\go" $goroot

  echo "Setting GOROOT and PATH for Machine"
  [System.Environment]::SetEnvironmentVariable("GOROOT", "$goroot", "Machine")
  $p = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
  $p = "$goroot\bin;$p"
  [System.Environment]::SetEnvironmentVariable("PATH", "$p", "Machine")
}



$cmdName="dep"
if (-Not (Get-Command $cmdName -errorAction SilentlyContinue)) {
  go get -d -u github.com/golang/dep
  go install github.com/golang/dep/cmd/dep
  # # needs to be updated temporarily, probably
  # $url="https://bin.equinox.io/a/59wHzG494MG/github-com-golang-dep-cmd-dep-windows-amd64.zip"
  # $downloadDir = $env:TEMP
  # Write-Output "Downloading $url"
  # $zip = "$downloadDir\dep.zip"
  # if (!(Test-Path "$zip")) {
  #   $downloader = new-object System.Net.WebClient
  #   $downloader.DownloadFile($url, $zip)
  # }

  # Write-Output "Extracting $zip to $goroot"
  # if (Test-Path "$downloadDir\dep.exe") {
  #   Remove-Item -Force -Recurse -Path "$downloadDir\dep.exe"
  # }
  # Add-Type -AssemblyName System.IO.Compression.FileSystem
  # [System.IO.Compression.ZipFile]::ExtractToDirectory("$zip", $downloadDir)
  # Move-Item "$downloadDir\dep.exe" $env:ProgramFiles
}
