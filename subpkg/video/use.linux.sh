#!/bin/bash

# make vlc the default video application
sed -n '
1i[Default Applications]
/^video/{
s/Totem/vlc/
s/org\.gnome\.//p
}' /usr/share/applications/defaults.list > ~/.local/share/applications/defaults.list
