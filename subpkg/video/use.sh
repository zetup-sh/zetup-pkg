#!/bin/bash

snap_install ffmpeg

# make vlc the default video application
defaults_folder="~/.local/share/applications/defaults.list"
if [ -d "${defaults_folder}" ] ; then
  sed -n '
  1i[Default Applications]
  /^video/{
  s/Totem/vlc/
  s/org\.gnome\.//p
  }' "${defaults_fodler}" > "${defaults_folder}"
fi
