#!/bin/bash
gsettings set org.gnome.desktop.background picture-uri "https://cdna.artstation.com/p/assets/images/images/002/120/516/large/alena-aenami-for-y1900.jpg?1457535992"


sudo add-apt-repository -u ppa:snwh/ppa
sudo apt install paper-icon-theme

[ $(lsb_release -cs) == "bionic" ]  && sudo apt install gnome-tweak-tool
[ $(lsb_release -cs) == "xenial" ]  && sudo apt install unity-tweak-tool


# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Paper"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Paper"

# install Ant
curl -L -O "https://dl.opendesktop.org/api/files/download/id/1561315339/s/1cee65a16cae87d035593dc7a69b0c562dd6e5623d1dfd2598130bb90126d947892183535853d8a1a8fdfab19bb4b94cdc1846992b6cbe5aeefe0894182aa562/t/1562679144/lt/download/Ant.tar"
tar -xvf Ant.tar
mkdir -p ~/.themes
mv Ant ~/.themes
rm Ant.tar

# install Catalina
curl -L -O https://github.com/B00merang-Project/macOS/archive/5.0.zip
unzip 5.0.zip
mv macOS-5.0 ~/.themes

gsettings set org.gnome.desktop.interface gtk-theme macOS-5.0
gsettings set org.gnome.desktop.wm.preferences theme macOS-5.0

echo "You can tweak the ui with the Tweaks application."
echo "More themes are available at https://www.gnome-look.org/browse/cat/135/ (just click on the theme you want, go to Files, and click install, then you can set it in the Tweaks Application"
