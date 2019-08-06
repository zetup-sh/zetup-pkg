#!/bin/bash

bash $ZETUP_SUB_PKG_DIR/fonts.sh

if [ "$XDG_CURRENT_DESKTOP" = "ubuntu:Gnome" ] || [ "$XDG_CURRENT_DESKTOP" = "unity" ]
then
  bash "$ZETUP_SUB_PKG_DIR"/unity.sh
elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]
then
  bash "$ZETUP_SUB_PKG_DIR"/xfce.sh
fi
