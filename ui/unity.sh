#!/bin/bash
gsettings set org.gnome.desktop.background picture-uri "https://cdna.artstation.com/p/assets/images/images/002/120/516/large/alena-aenami-for-y1900.jpg?1457535992"


sudo add-apt-repository -u ppa:snwh/ppa
sudo apt install paper-icon-theme
# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Paper"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Paper"
