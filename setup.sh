#!/usr/local/bin bash


echo "Linking dotfiles"
sh ./link-dotfiles.sh

echo "Installing programs"
for i in $(ls ~/zetup/install);
do  sh $HOME/install/$i ;
done

sh $HOME/zetup/ui.sh;

gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'virtualbox.desktop']"

cp -r $HOME/zetup/startup/zetup.desktop $HOME/.config/autostart

source $HOME/.bashrc

if [ -f $HOME/zetup/custom/setup.sh ];
then sh $HOME/zetup/custom/setup.sh;
fi

echo 'All Done!'
echo
echo "You can also customize the ui with \`sh ~/zetup/ui/xfce.sh\` or \`sh ~/zetup/ui/unity.sh\` depending on your desktop environment"
