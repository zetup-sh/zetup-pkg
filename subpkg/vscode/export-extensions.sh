#!/bin/bash

eval `zetup env`

if [ ! -x "$(command -v code)" ]
then
  echo Could not find installation of vs code
fi

active_extensions="$(code --list-extensions)"
saved_extensions_list_file="$ZETUP_USE_PKG/subpkg/vscode/config/extension_list.txt"

echo "$active_extensions" > "$saved_extensions_list_file"
