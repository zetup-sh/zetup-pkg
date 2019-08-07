#!/bin/bash

## source code pro
if [ ! -d "/usr/share/fonts/opentype/scp" ]
then
  echo installing source code pro
  sudo git clone --depth=1 https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
  sudo rm -rf /usr/share/fonts/opentype/scp/.git*
fi

# hack
if [ ! -d /usr/share/fonts/ttf/hack ]
  then
    echo installing hack
    curl -L -O https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
    unzip Hack-v3.003-ttf.zip -d hack
    sudo mv hack /usr/share/fonts/ttf
    rm Hack-v3.003-ttf.zip
    rm -rf ttf
fi

# hasklig
if [ ! -d /usr/share/fonts/ttf/hasklig ]
  then
    echo installing hasklig
    curl -L -O https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
    unzip Hasklig-1.1.zip -d hasklig
    sudo mv hasklig /usr/share/fonts/ttf
    rm Hasklig-1.1.zip
fi


# fira sans
if [ ! -d /usr/share/fonts/opentype/fira ]
  then
    echo installing fira 🔥
    wget https://github.com/bBoxType/FiraSans/archive/master.zip
    unzip master.zip
    sudo mkdir -p /usr/share/fonts/opentype/fira
    sudo mkdir -p /usr/share/fonts/truetype/fira
    find FiraSans-master/ -name "*.otf" -exec sudo cp {} /usr/share/fonts/opentype/fira/ \;
    find FiraSans-master/ -name "*.ttf" -exec sudo cp {} /usr/share/fonts/truetype/fira/ \;
    rm -r master.zip  FiraSans-master
fi
