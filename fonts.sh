#!/bin/bash

mkdir -p /usr/share/fonts/ttf

# fira code
apt install fonts-firacode
apt install ttf-dejavu

# source code pro
[ -d /usr/share/fonts/opentype ] || mkdir /usr/share/fonts/opentype
git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
rm -rf /usr/share/fonts/opentype/scp/.git*


# hack
curl -L -O https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip Hack-v3.003-ttf.zip -d hack
cp -r hack /usr/share/fonts/ttf
rm Hack-v3.003-ttf.zip
rm -rf ttf

# hasklig
curl -L -O https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
unzip Hasklig-1.1.zip -d hasklig
cp -r hasklig /usr/share/fonts/ttf
rm Hasklig-1.1.zip

