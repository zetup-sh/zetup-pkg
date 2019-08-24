#!/bin/bash

source "$ZETUP_CUR_PKG/pkg-install-fns.sh"

apt_pkgs=(
  # add your pacman packages here
  "tmux"
  "cmake"
  "apt-transport-https"
  "wget"
  "ca-certificates"
  "software-properties-common"
  "snapd"
  "git"
  "xclip"
  "net-tools"
  "python-pip"
  "python3-pip"
)
apt_install $apt_pkgs

pacman_pkgs=(
  # add your pacman packages here
  "snapd"
  "binutils"
  "base-devel"
  "cmake"
  "python2-pip"
  "python-pip"
)
pacman_install $pacman_pkgs

snap_pkgs=(
  # add your snap packages here
  "jq"
)
snap_install $snap_pkgs

snap_classic_pkgs=(
  # add your snap --classic packages here
  # "slack"
)
snap_classic_install $snap_classic_pkgs

# install brew on mac
if [ "$(uname)" == "darwin" ]
then
  if [ ! -x "$(command -v brew)" ]
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

brew_pkgs=(
  # your brew packages here
  "wget"
)
brew_install $brew_pkgs


zetup link "$ZETUP_CUR_PKG/dotfiles/bashrc.sh" "$HOME/.bashrc"
zetup link "$ZETUP_CUR_PKG/dotfiles/aliases.sh" "$HOME/.aliases"
zetup link "$ZETUP_CUR_PKG/dotfiles/fns.sh" "$HOME/.fns"
zetup link "$ZETUP_CUR_PKG/dotfiles/tmux.conf" "$HOME/.tmux.conf"
zetup link "$ZETUP_CUR_PKG/dotfiles/vimrc" "$HOME/.vimrc"

source "$HOME/.bashrc"

for f in "$ZETUP_CUR_PKG"/subpkg/*/use.sh
do
  bash $f
done