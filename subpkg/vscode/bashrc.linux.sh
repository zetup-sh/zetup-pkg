eval `zetup env`
exportconfig() {
  sh "$ZETUP_USE_PKG/subpkg/vscode/exportconfig.sh"
}
importconfig() {
  sh "$ZETUP_USE_PKG/subpkg/vscode/importconfig.sh"
}
