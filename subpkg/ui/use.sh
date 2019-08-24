#!/bin/bash

bash $ZETUP_CUR_PKG/subpkg/ui/fonts.sh


if [ "$XDG_CURRENT_DESKTOP" == "ubuntu:GNOME" ] || [ "$XDG_CURRENT_DESKTOP" == "unity" ]
then
  bash "$ZETUP_CUR_PKG/subpkg/ui/unity.sh"
elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]
then
  bash "$ZETUP_CUR_PKG/subpkg/ui/xfce.sh"
else 
  echo coulnt find desk top
fi
