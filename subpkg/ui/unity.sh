#!/bin/bash
gsettings set org.gnome.desktop.background picture-uri "https://cdna.artstation.com/p/assets/images/images/002/120/516/large/alena-aenami-for-y1900.jpg?1457535992"


if [ ! -d "/usr/share/icons/Paper" ]
then
sudo add-apt-repository -u ppa:snwh/ppa -y
sudo apt install paper-icon-theme
fi

[ $(lsb_release -cs) == "bionic" ] && [ ! -x "$(command -v gnome-tweaks)" ] &&  sudo apt install gnome-tweak-tool -y
[ $(lsb_release -cs) == "xenial" ]  && [ ! -x "$(command -v unity-tweak-tool)" ] && sudo apt install unity-tweak-tool -y

if [ ! -x "$(command -v gnome-shell-extension-tool)" ]
then
sudo apt-get install gnome-shell-extensions -y
fi

# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Paper"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Paper"

# install Ant
if [ ! -d $HOME/.themes/Ant ]
then
curl -L -O "https://github.com/EliverLara/Ant/archive/master.zip"
unzip master.zip
mkdir -p $HOME/.themes
mv Ant-master $HOME/.themes/Ant
rm master.zip
fi

# install Catalina
curl -L -O https://github.com/B00merang-Project/macOS/archive/5.0.zip
unzip -n 5.0.zip
cp -r macOS-5.0 ~/.themes
rm -rf macOS-5.0
rm 5.0.zip

gsettings set org.gnome.desktop.interface gtk-theme macOS-5.0
gsettings set org.gnome.desktop.wm.preferences theme macOS-5.0

echo "You can tweak the ui with the Tweaks application."
echo "More themes are available at https://www.gnome-look.org/browse/cat/135/ (just click on the theme you want, go to Files, and click install, then you can set it in the Tweaks Application"
echo "You can set the terminal theme with \`get-theme\`, you can see what the themes look like at https://mayccoll.github.io/Gogh/"
