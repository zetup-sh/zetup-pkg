#!/bin/bash

# add function to save config here

eval `zetup env`

if [ ! -x "$(command -v code)" ]
then
  echo Could not find installation of vs code
fi

active_settings_file="$HOME/.config/Code/User/settings.json"
active_key_bindings_file="$HOME/.config/Code/User/keybindings.json"
active_extensions="$(code --list-extensions)"

saved_extensions_list_file="$ZETUP_USE_PKG/subpkg/vscode/config/extension_list.txt"
saved_settings_file="$ZETUP_USE_PKG/subpkg/vscode/config/settings.json"
saved_key_bindings_file="$ZETUP_USE_PKG/subpkg/vscode/config/key_bindings.json"

if [ ! -f "$active_settings_file" ]
then
  echo Could not find settings file \("$active_settings_file"\)
fi

if [ ! -f "$active_key_bindings_file" ]
then
  echo Could not find key bindings file \("$active_key_bindings_file"\)
fi

# install all missing extensions
saved_extensions="$(cat $saved_extensions_list_file)"
for ext in "$saved_extensions"
do
  $(echo "$active_extensions" | grep -q "$ext") || code --install-extension "$ext"
done

# copy settings files
cp -rf "$saved_settings_file" "$settings_file" 
cp -rf "$saved_key_bindings_file" "$key_bindings_file"
