#!/bin/bash

if [ "$(uname -m)" == "x86_64" ] ; then
  ARCH="amd64"
  VERSION="1.12.9"
  OS=$(echo "$(uname)" | tr '[:upper:]' '[:lower:]')
else
  exit # not tested on 32 bit...might work though
fi

# install if it's not already installed
if [ ! -x "$(command -v go)" ] ; then
  if [ "$(uname)" == "Linux" ] ; then
    wget "https://dl.google.com/go/go$go_version.linux-amd64.tar.gz"
    sudo tar -xvf "go$go_version.linux-amd64.tar.gz"
    rm "go$go_version.linux-amd64.tar.gz"
    sudo mv go /usr/local
    mkdir -p $HOME/go/src/{github.com,gitlab.com}
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
  fi
fi
