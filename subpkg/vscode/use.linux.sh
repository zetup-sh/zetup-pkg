#!/bin/bash

mkdir -p "$HOME/.config/Code/User"

if [ ! -x "$(command -v code)" ]
then
sudo snap install --classic code
fi

eval `zetup env`

sh "$ZETUP_USE_PKG/subpkg/vscode/import-extensions.sh"
