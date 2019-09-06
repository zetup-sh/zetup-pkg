#!/bin/bash

if [ ! -x "$(command -v virtualbox)" ] ; then
  if [ -x "$(command -v apt-get)" ] ; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
    sudo apt update
    sudo apt-get -y install virtualbox-6.0
  fi

  # TODO: not tested
  if [ -x "$(command -v rpm)" ] ; then
    sudo rpm --import oracle_vbox.asc
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | rpm --import -
    zypper refresh
  fi
fi

if [ -x "$(command -v pacman)" ]; then
  pamac_install virtualbox $(pacman -Qsq "^linux" | grep "^linux[0-9]*[-rt]*$" | awk '{print $1"-virtualbox-host-modules"}' ORS=' ')
fi

brew_cask_install virtualbox