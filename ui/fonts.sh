#!/bin/bash

mkdir -p /usr/share/fonts/ttf

# fira code
sudo apt install fonts-firacode
sudo apt install ttf-dejavu

# source code pro
[ -d /usr/share/fonts/opentype ] || mkdir /usr/share/fonts/opentype
git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
rm -rf /usr/share/fonts/opentype/scp/.git*


# hack
curl -L -O https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip Hack-v3.003-ttf.zip -d hack
mv hack /usr/share/fonts/ttf
rm Hack-v3.003-ttf.zip
rm -rf ttf

# hasklig
curl -L -O https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
unzip Hasklig-1.1.zip -d hasklig
mv -r hasklig /usr/share/fonts/ttf
rm Hasklig-1.1.zip


# fira sans
wget https://github.com/bBoxType/FiraSans/archive/master.zip
unzip master.zip
sudo mkdir -p /usr/share/fonts/opentype/fira
sudo mkdir -p /usr/share/fonts/truetype/fira
sudo find FiraSans-master/ -name "*.otf" -exec cp {} /usr/share/fonts/opentype/fira/ \;
sudo find FiraSans-master/ -name "*.ttf" -exec cp {} /usr/share/fonts/truetype/fira/ \;
rm -r master.zip  FiraSans-master
