#!/bin/bash

## source code pro
if [ ! -d "/usr/share/fonts/opentype/scp" ]
then
  echo couldnt find scp
  sudo git clone --depth=1 https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
  sudo rm -rf /usr/share/fonts/opentype/scp/.git*
else
  echo \`source code pro\` already installed
fi

# hack
if [ ! -d /usr/share/fonts/ttf/hack ]
  then
    curl -L -O https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
    unzip Hack-v3.003-ttf.zip -d hack
    sudo mv hack /usr/share/fonts/ttf
    rm Hack-v3.003-ttf.zip
    rm -rf ttf
  else
    echo \`hack\` already installed
fi

# hasklig
if [ ! -d /usr/share/fonts/ttf/hasklig ]
  then
    curl -L -O https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
    unzip Hasklig-1.1.zip -d hasklig
    sudo mv hasklig /usr/share/fonts/ttf
    rm Hasklig-1.1.zip
  else
    echo \`hasklig\` already installed
fi


# fira sans
if [ ! -d /usr/share/fonts/opentype/fira ]
  then
    wget https://github.com/bBoxType/FiraSans/archive/master.zip
    unzip master.zip
    sudo mkdir -p /usr/share/fonts/opentype/fira
    sudo mkdir -p /usr/share/fonts/truetype/fira
    find FiraSans-master/ -name "*.otf" -exec sudo cp {} /usr/share/fonts/opentype/fira/ \;
    find FiraSans-master/ -name "*.ttf" -exec sudo cp {} /usr/share/fonts/truetype/fira/ \;
    rm -r master.zip  FiraSans-master
  else
    echo \`fira\` already installed
fi
