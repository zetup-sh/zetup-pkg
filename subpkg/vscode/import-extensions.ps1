$cmdName="code"
if (-Not (Get-Command $cmdName -errorAction SilentlyContinue)) {
    "No code installation found. VS Code should be installed."
    exit
}

$active_extensions=`code --list-extensions`
$saved_extensions_list_file="$env:ZETUP_CUR_PKG/subpkg/vscode/config/extension_list.txt"

# install all missing extensions
[string[]]$saved_extensions = Get-Content -Path $saved_extensions_list_file

$extensionString=""
foreach ($ext in $saved_extensions) {
  if (-Not ($active_extensions -contains $ext)) {
    $extensionString+=" --install-extension $ext "
  }
}
if ($extensionString -ne "") {
  Invoke-Expression ("code "+$extensionString)
}