#!/bin/bash
if [ -z $INCONTAINER ]
  then sleep 1 # idk why, but it doesn't work without this
fi

mustopen() {
  if [ ! -z $IN_CONTAINER ]
    then
      echo "Please open $1 in your browser and create a personal access token with the following scope:"
      echo repo
      echo admin:public_key
      echo user
      echo
      echo then paste the access key here:
      read ZETUP_GITHUB_KEY
  else
    if [ -x "$(command -v sensible-browser)" ]
      then
        echo using sensible browser
        sensible-browser $1
    elif [ -x "$(command -v xdg-open)" ]
      then xdg-open $1;
    else
      sudo apt update && sudo apt install -y sensible-browser && sensible-browser $1;
      if [ ! -x "$(command -v sensible-browser)" ]
        then
          echo "could not locate or install a browser"
          exit 1
      fi
    fi
  fi
}


# TODO gitlab support
if [ -z $ZETUP_GITHUB_PAT ];
  then
    echo "ZETUP_GITHUB_PAT not set. Please create a personal access token with all privileges enabled"
    mustopen https://github.com/settings/tokens/new
  else
    echo "using \$ZETUP_GITHUB_PAT"
fi
if [ ! -x "$(command -v jq)" ]
then
sudo snap install jq
fi

username=$(curl -s -H "Authorization: token $ZETUP_GITHUB_PAT" https://api.github.com/user | jq -r ".login")
git ls-remote "git@github.com:$username/zetup.git" -q

if [ $? = 0 ]
then
  public_exists=true
else
  public_exists=false
fi

echo $public_exists




exit


  
# general user info
if [ -z "$NAME" ];
then echo "What is your full name?" && read NAME;
else echo "Name is set to $NAME";
fi

if [ -z "$EMAIL" ];
then echo "What is your email?" && read EMAIL;
else echo "Email is set to $EMAIL";
fi

if [ -z "$GITHUB_USERNAME" ];
then echo "\$GITHUB_USERNAME not set. What is your github username?"  && read USERNAME;
else echo "Username is set to $USERNAME"
fi

# generate ssh key and add to github
sudo apt-get update
sudo apt install -y \
  git \
  xclip
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N ""
fi
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
echo;
if $IN_CONTAINER ; 
  then
    echo copy this key and paste it into your github/gitlab account
    cat ~/.ssh/id_rsa.pub
    echo https://gitlab.com/profile/keys  https://github.com/settings/ssh/new ;
  else 
    cat ~/.ssh/id_rsa.pub | xclip -selection c
    echo
    echo "Your github and/or gitlab key was automatically copied to your clipboard."
    echo "Paste it into your account in the new browser window."
    echo "Please create an account if you don't already have one."
    echo
    google-chrome https://gitlab.com/profile/keys  https://github.com/settings/ssh/new ;
fi
echo
echo
echo
read -p  "Press enter once you have added the keys to your account "
echo

# install chrome and make it the default browser
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt install -yqq google-chrome-stable
xdg-settings set default-web-browser google-chrome.desktop

# general essential utilities
sudo apt install -y \
  install \
  tmux \
  cmake \
  apt-transport-https \
  curl \
  ca-certificates \
  software-properties-common \
  google-chrome-stable \
  xclip \
  snapd \
  sensible-browser
  


ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts

git clone "https://github.com/zwhitchcox/zetup.git" $HOME/zetup 
# uncomment the below line and comment the above line to use your own repo
#git clone "git@github.com/$USERNAME/zetup.git" $HOME/zetup 
cd $HOME/dotfiles
cp -r .bin ~/.bin
git clone git@github.com:zwhitchcox/zetup.git $HOME/zetup
cd $HOME/zetup
mkdir ~/dev
find . -maxdepth 1 -regextype posix-egrep -regex "\.\/\..*" ! -name .git -exec cp -t .. {} +
sed -i "1s/^export username=$USERNAME/\n/" ~/.bashrc
snap install yq
source setup.sh
