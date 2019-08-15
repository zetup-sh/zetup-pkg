#!/bin/bash

if [ ! -x "$(command -v google-chrome-stable)" ]
then
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt install google-chrome-stable -yqq
xdg-settings set default-web-browser google-chrome.desktop
exit 0
fi
