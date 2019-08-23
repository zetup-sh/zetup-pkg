#!/bin/bash

# apt installations - darwin based systems
if [ -x "$(command -v apt-get)" ]
then
  apt_installations=(
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
  apt_cache_prefix="installed-apt-"
  to_install=""
  for pkg in "${apt_installations[@]}"
  do
    if [ "$(zetup cache get $apt_cache_prefix$pkg)" != "true" ]
    then
      to_install="$to_install $pkg"
    fi
  done
  if [ -n "${to_install}" ]
  then
    sudo apt-get update
    sh -c "sudo apt install $to_install -yqq" && \
    for pkg in "${apt_installations[@]}"
    do
      zetup cache set "$apt_cache_prefix$pkg" true
    done
  fi
fi

if [ -x "$(command -v snap)" ]
then
  apt_installations=(
    "yq"
  )
  to_install=""
  snap_cache_prefix="installed-snap"
  for pkg in "${apt_installations[@]}"
  do
    if [ "$(zetup cache get $snap_cache_prefix$pkg)" != "true" ]
    then
      sudo snap install "$pkg" && \
      zetup cache set "$snap_cache_prefix$pkg" true
    fi
  done
fi


# install brew on mac
if [ "$(uname)" == "darwin" ]
then
  if [ ! -x "$(command -v brew)" ]
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

zetup link "$ZETUP_USE_PKG/dotfiles/bashrc.sh" "$HOME/.bashrc"
zetup link "$ZETUP_USE_PKG/dotfiles/aliases.sh" "$HOME/.aliases"
zetup link "$ZETUP_USE_PKG/dotfiles/fns.sh" "$HOME/.fns"
zetup link "$ZETUP_USE_PKG/dotfiles/tmux.conf" "$HOME/.tmux.conf"
zetup link "$ZETUP_USE_PKG/dotfiles/vimrc" "$HOME/.vimrc"

source "$HOME/.bashrc"

for f in "$ZETUP_USE_PKG"/subpkg/*/use.sh
do
  bash $f
done