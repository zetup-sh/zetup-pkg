
$cmdName="code"
if (-Not (Get-Command $cmdName -errorAction SilentlyContinue)) {
  choco install vscode
}

powershell "$ZETUP_CUR_PKG/subpkg/vscode/import-extensions.ps1"

# link settings
$user_dir="$HOME\AppData\Roaming\Code\User"

zetup link "$ZETUP_CUR_PKG/subpkg/vscode/config/settings.json" "$user_dir/settings.json"
zetup link "$ZETUP_CUR_PKG/subpkg/vscode/config/keybindings.json" "$user_dir/keybindings.json"