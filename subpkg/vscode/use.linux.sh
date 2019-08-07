#!/bin/bash

if [ ! -x "$(command -v code)" ]
then
sudo snap install --classic code
fi

# make backup of settings files for unuse
eval `zetup env`


active_settings_file="$HOME/.config/Code/User/settings.json"
settings_bak="$ZETUP_USE_PKG/subpkg/vscode/config/settings.json.bak"
active_key_bindings_file="$HOME/.config/Code/User/keybindings.json"
key_bindings_bak="$ZETUP_USE_PKG/subpkg/vscode/config/keybindings.json.bak"


if [ -f "$active_settings_file" ]
then
  cp -rf "$active_settings_file" "$settings_bak"
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



