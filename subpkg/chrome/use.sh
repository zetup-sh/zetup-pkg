#!/bin/bash

# install chrome if on debian
if [ -x "$(command -v apt-get)" ] ; then
  if [ ! -x "$(command -v google-chrome-stable)" ] ; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt-get update
    sudo apt-get install google-chrome-stable -yqq
    xdg-settings set default-web-browser google-chrome.desktop
  fi

elif [ -x "$(command -v pacman)" ]; then
  if [ ! -x "$(command -v google-chrome-stable)" ]; then
    cd /tmp
    git clone https://aur.archlinux.org/google-chrome.git
    cd google-chrome
    makepkg -s
    sudo pacman -U --noconfirm  google-chrome*.xz
  fi

# only chromium is available on other distros (except Fedora)
else
  snap_install chromium
  brew_cask_install google-chrome
fi