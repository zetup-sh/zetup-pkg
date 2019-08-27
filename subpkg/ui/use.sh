#!/bin/bash

bash $ZETUP_CUR_PKG/subpkg/ui/fonts.sh


if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] ; then
  bash "$ZETUP_CUR_PKG/subpkg/ui/gnome.sh"
elif [[ "$XDG_CURRENT_DESKTOP" == *"XFCE"* ]] ; then
  bash "$ZETUP_CUR_PKG/subpkg/ui/xfce.sh"
else
  echo "couldn't find desk top"
fi
