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


echo "$active_extensions" > "$saved_extensions_list_file"
cp -rf "$settings_file" "$saved_settings_file"
cp -rf "$key_bindings_file" "$saved_key_bindings_file"
