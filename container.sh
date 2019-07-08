sudo apt-get update
sudo apt-get -y install tmux git cmake apt-transport-https curl ca-certificates software-properties-common xclip
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts
git clone https://gitlab.com/zwhitchcox/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
cp -r .bin ~/.bin
mkdir ~/dev
find . -maxdepth 1 -regextype posix-egrep -regex "\.\/\..*" ! -name .git -exec cp -t .. {} +
snap install yq
source setup.sh
