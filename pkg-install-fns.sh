#!/bin/bash

## IGNORE THIS FILE UNLESS YOU WANT TO ADD A PACKAGE MANAGER ##

pacman_install() {
  pkg_install pacman pacman_install_hof "${@}"
}

pacman_install_hof() {
  # pacman installations - arch based systems
  for pkg in "$@" ; do
    sudo pacman -S --noconfirm $pkg
  done
}

apt_install() {
  pkg_install apt-get apt_install_hof "${@}"
}

apt_install_hof() {
  sudo apt-get update
  sudo apt install "${@}" -yqq
}

snap_classic_install() {
  pkg_install snap snap_classic_install_hof "${@}"
}

snap_classic_install_hof() {
  for pkg in "$@" ; do
    sudo snap install --classic $pkg
  done
}

pamac_install() {
  pkg_install pamac pamac_install_hof "${@}"
}

pamac_install_hof() {
  sudo pamac install --no-confirm "${@}"
}

brew_install() {
  pkg_install brew brew_install_hof "${@}"
}

brew_install_hof() {
  for pkg in "$@" ; do
    sudo brew install $pkg
  done
}

brew_cask_install() {
  pkg_install brew brew_install_hof "${@}"
}

brew_cask_install_hof() {
  for pkg in "$@" ; do
    sudo brew cask install $pkg
  done
}

snap_install() {
  pkg_install snap snap_install_hof "${@}"
}

snap_install_hof() {
  for pkg in "$@" ; do
    sudo snap install $pkg
  done
}

# takes a command, an install function, and packages to install
# if the command exists, it checks the cache to see if
# the packages are already installed.
# any that aren't in the cache are passed to the install function
pkg_install() {
  command="$1"
  install_hof=$2 # Higher Order Function

  # check if command exists
  if [ -x "$(command -v $command)" ] ; then
    pac_cache_prefix="installed-$command-"
    to_install=()
    for (( i=3; i<=$#; i++)) {
      eval pkg='${'$i'}'
      # check cache to see if it's already installed
      if [ "$(zetup cache get $pac_cache_prefix$pkg)" != "true" ] ; then
        to_install+=("$pkg")
      fi
    }
    if [ "${#to_install[@]}" -ne 0 ] ; then
      $install_hof "${to_install[@]}" &&
      # mark true in cache so we know it's installed
      for pkg in "${to_install[@]}" ; do
        zetup cache set "$pac_cache_prefix$pkg" true
      done
    fi
  fi
}
