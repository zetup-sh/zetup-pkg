#!/bin/bash

# install nvm if not already
NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ] ; then
  NVM_VERSION="v12.4.0"
  mkdir $HOME/.nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install "$NVM_VERSION"
fi


# install node if not already
if [ ! -x "$(command -v node)" ] ; then
  nvm install node
  sudo ln -s $(which npm) /usr/bin/npm
  sudo ln -s $(which node) /usr/bin/node
fi

# install node if not already
if [ ! -x "$(command -v yarn)" ] ; then
  if [ -x "$(command -v apt-get)" ] ; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn -y --no-install-recommends
  fi
fi

pacman_install yarn

toinstallglobalyarn=""

# global install packages
maybe_install=(
  "ts-node"
  "nodemon"
  "webpack"
  "jest"
  "pm2"
  "tsc/typescript" # split command to test for and package with /
  "create-react-app"
)

for pkg in "${maybe_install[@]}"
do
  pkg_split=(${pkg//\// })
  test_cmd=${pkg_split[0]}
  pkg_name=${pkg_split[1]}
  if [ "$pkg_name" == "" ] ; then
    pkg_name=${test_cmd}
  fi
  to_install=""
  if [ ! "$(command -v $test_cmd)" ] ; then
    to_install="${to_install} ${pkg_name}"
  fi
  if [ "${to_install}" != "" ] ; then
    yarn global add "${to_install}"
  fi
done
