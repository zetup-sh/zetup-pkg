#!/bin/bash

# install nvm if not already
NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]
then
NVM_VERSION="v12.4.0"
mkdir $HOME/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi


# install node if not already
if [ ! -x "$(command -v node)" ]
then
nvm install node
sudo ln -s $(which npm) /usr/bin/npm
sudo ln -s $(which node) /usr/bin/node
fi

# install node if not already
if [ ! -x "$(command -v yarn)" ]
then
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn -y --no-install-recommends
fi

toinstallglobalyarn=""

if [ ! -x "$(command -v tsc)" ]
then
  toinstallglobalyarn="$toinstallglobalyarn typescript"
fi

for i in ts-node nodemon webpack jest pm2
do
  if [ ! -x "$(command -v $i)" ]
  then
  toinstallglobalyarn="$toinstallglobalyarn $i"
  fi
done

if [ ! "$toinstallglobalyarn" == "" ];
then
  echo "toinstall: $toinstallglobalyarn"
  yarn global add $toinstallglobalyarn
fi
