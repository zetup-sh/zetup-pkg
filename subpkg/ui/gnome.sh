#!/bin/bash

gsettings set org.gnome.desktop.background picture-uri "https://unsplash.com/photos/sseiVD2XsOk/download?force=true"


if [ ! -d "/usr/share/icons/Paper" ] ; then
  sudo add-apt-repository -u ppa:snwh/ppa -y
fi

apt_pkgs=(
  "paper-icon-theme"
  "gnome-tweak-tool"
)

apt_install apt_pkgs

if [ ! -x "$(command -v gnome-shell-extension-tool)" ] ; then
  sudo apt-get install gnome-shell-extensions -y
fi

# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Paper"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Paper"

# install Ant
if [ ! -d "$HOME/.themes/Ant" ] ; then
  curl -L -O "https://github.com/EliverLara/Ant/archive/master.zip"
  unzip master.zip
  mkdir -p "$HOME/.themes"
  mv Ant-master "$HOME/.themes/Ant"
  rm master.zip
fi

# install Catalina
if [ ! -d "$HOME/.themes/macOS-5.0" ] ; then
  curl -L -O https://github.com/B00merang-Project/macOS/archive/5.0.zip
  unzip -n 5.0.zip
  mv macOS-5.0 "$HOME/.themes"
  rm 5.0.zip
fi

gsettings set org.gnome.desktop.interface gtk-theme macOS-5.0
gsettings set org.gnome.desktop.wm.preferences theme macOS-5.0

#echo "You can tweak the ui with the Tweaks application."
#echo "More themes are available at https://www.gnome-look.org/browse/cat/135/ (just click on the theme you want, go to Files, and click install, then you can set it in the Tweaks Application"
#echo "You can set the terminal theme with \`get-theme\`, you can see what the themes look like at https://mayccoll.github.io/Gogh/"
