#!/usr/local/bin bash


echo "Linking dotfiles"
sh ./link-dotfiles.sh

echo "Installing programs"
sh ./install/*.sh

sh $HOME/zetup/ui.sh;


source ~/.bashrc

if [ -f $HOME/zetup/custom/setup.sh ];
then sh $HOME/zetup/custom/setup.sh;
fi

echo 'All Done!'
echo
echo "You can also customize the ui with `sh ~/zetup/ui/xfce.sh` or `sh ~/zetup/ui/unity.sh` depending on your desktop environment"
