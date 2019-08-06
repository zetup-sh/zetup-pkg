#!/bin/bash

# install if it's not already installed
if [ -x "$(command -v go)" ]
then
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
sudo tar -xvf go1.12.6.linux-amd64.tar.gz
rm go1.12.6.linux-amd64.tar.gz
sudo mv go /usr/local
mkdir -p $HOME/go/src/{github.com,gitlab.com}
fi
