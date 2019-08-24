#!/bin/bash

eval `zetup env`
if [ ! -x "$(command -v code)" ]
then
  echo Could not find installation of vs code
fi

active_extensions=`code --list-extensions`
saved_extensions_list_file="$ZETUP_CUR_PKG/subpkg/vscode/config/extension_list.txt"

# install all missing extensions
saved_extensions=`cat $saved_extensions_list_file`
for ext in $saved_extensions
do
  $(echo "$active_extensions" | grep -q "$ext") || code --install-extension "$ext"
done
