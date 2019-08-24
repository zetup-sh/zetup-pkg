eval `zetup env`
codeexportextensions() {
  sh "$ZETUP_CUR_PKG/subpkg/vscode/export-extensions.sh"
}
codeimportextensions() {
  sh "$ZETUP_CUR_PKG/subpkg/vscode/import-extensions.sh"
}
