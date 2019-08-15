eval `zetup env`
codeexportextensions() {
  sh "$ZETUP_USE_PKG/subpkg/vscode/export-extensions.sh"
}
codeimportextensions() {
  sh "$ZETUP_USE_PKG/subpkg/vscode/import-extensions.sh"
}
