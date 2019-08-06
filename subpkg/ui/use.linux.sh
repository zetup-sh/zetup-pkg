#!/bin/bash

bash $ZETUP_PKG_DIR/subpkg/ui/fonts.sh

if [ "$XDG_CURRENT_DESKTOP" = "ubuntu:Gnome" ] || [ "$XDG_CURRENT_DESKTOP" = "unity" ]
then
  bash "$ZETUP_PKG_DIR"/unity.sh
elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]
then
  bash "$ZETUP_PKG_DIR"/xfce.sh
fi
