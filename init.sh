#!/bin/bash
sleep 1

if [ -z "$name" ];
then echo "What is your full name?" && read name;
else echo "Name is set to $name";
fi

if [ -z "$email" ];
then echo "What is your email?" && read email;
else echo "Email is set to $email";
fi

if [ -z "$username" ];
then echo "What is your username? Please use a consistent username with github/gitlab, npm, etc."  && read username;
else echo "Username is set to $username"
fi


find $HOME/zetup -type f -iname "*.sh" -exec chmod +x {} \;

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt-get update
sudo apt-get -y install tmux git cmake apt-transport-https curl ca-certificates software-properties-common google-chrome-stable xclip snapd

xdg-settings set default-web-browser google-chrome.desktop

git config --global user.name "$name"
git config --global user.email "$email"
git config --global core.editor vim
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N ""
fi
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
echo;
if $IN_CONTAINER ; 
then echo copy this key and paste it into your github/gitlab account
cat ~/.ssh/id_rsa.pub
echo https://gitlab.com/profile/keys  https://github.com/settings/ssh/new ;
else 
echo "Your github and/or gitlab key has been copied to your clipboard. Paste it into your account in the new browser window. Please create an account if you don't already have one."
echo
cat ~/.ssh/id_rsa.pub | xclip -selection c
echo
echo
echo
google-chrome https://gitlab.com/profile/keys  https://github.com/settings/ssh/new ;

fi

echo;
read -p  "Press enter continue: "
echo;
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts
git clone git@gitlab.com:zwhitchcox/zetup.git $HOME/zetup
cd $HOME/zetup
mkdir ~/dev
find . -maxdepth 1 -regextype posix-egrep -regex "\.\/\..*" ! -name .git -exec cp -t .. {} +
sudo snap install yq code
source setup.sh
