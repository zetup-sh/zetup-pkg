#!/bin/bash

source "$ZETUP_CUR_PKG/pkg-install-fns.sh"

apt_install (
  # add your apt packages here
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
)

pacman_install (
  # add your pacman packages here
  "snapd"
  "binutils"
  "base-devel"
)

snap_install (
  # add you snap packages here
  "jq"
)

snap_classic_install (
  # "slack"
)

# install brew on mac
if [ "$(uname)" == "darwin" ]
then
  if [ ! -x "$(command -v brew)" ]
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

brew_install (
  # your brew packages here
  "wget"
)


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