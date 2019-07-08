#!/usr/local/bin bash


echo "Linking dotfiles"
sh ./link-dotfiles.sh

echo "Installing programs"
sh ./install/*.sh

echo "Installing fonts"
sh ./fonts.sh

echo "Install the ui for your distro with sh ~/zetup/{YOUR_DISTRO}.sh"

source ~/.bashrc

if [ -f $HOME/zetup/custom/setup.sh ];
then sh $HOME/zetup/custom/setup.sh;
fi

echo 'All Done!'
