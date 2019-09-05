#!/bin/bash

mkdir -p "$HOME/dev"


. "$ZETUP_CUR_PKG/pkg-install-fns.sh"

apt_pkgs=(
  # add your pacman packages here
  "tmux"
  "cmake"
  "apt-transport-https"
  "wget"
  "curl"
  "ca-certificates"
  "software-properties-common"
  "snapd"
  "git"
  "xclip"
  "net-tools"
  "python-pip"
  "python3-pip"
)
apt_install ${apt_pkgs[@]}

pacman_pkgs=(
  # add your pacman packages here
  "binutils"
  "base-devel"
  "cmake"
  "python2-pip"
  "python-pip"
  "curl"
)
pacman_install ${pacman_pkgs[@]}
if ( [ -x "$(command -v pacman)" ] && \
    [ ! -x "$(command -v snap)" ] ); then
  pacman_install snapd
  sudo systemctl enable snapd
  sudo systemctl start snapd
  i=0
  while ! echo "$(sudo systemctl status snapd)" | grep -m1 "active (running)"  ; do
    sleep 1 # wait for snapd to start
    if [ i -gt 5 ] ; then # it's apparently not going to start
      echo "Warning: Snap service didn\'t start"
      echo "Snap packages might not be installed"
      break
    fi
  done
  source /etc/profile.d/snapd.sh
fi


snap_pkgs=(
  # add your snap packages here
  "jq"
)
snap_install ${snap_pkgs[@]}

snap_classic_pkgs=(
  # add your snap --classic packages here
  # "slack"
)
snap_classic_install ${snap_classic_pkgs[@]}

if [ "$(uname)" == "Darwin" ]; then
  # install developer tools
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
  grep "\*.*Command Line.*$(sw_vers -productVersion|awk -F. '{print $1"."$2}')" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
  softwareupdate -i "$PROD" --verbose
  rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

  # install brew
  if [ ! -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

brew_pkgs=(
  # your brew packages here
  "wget"
)
brew_install ${brew_pkgs[@]}

ssh-add $ZETUP_PRIVATE_KEY_FILE  2>/dev/null

zetup link "$ZETUP_CUR_PKG/bash/bashrc.sh" "$HOME/.bashrc"
zetup link "$ZETUP_CUR_PKG/bash/aliases.sh" "$HOME/.aliases"
zetup link "$ZETUP_CUR_PKG/bash/fns.sh" "$HOME/.fns"
zetup link "$ZETUP_CUR_PKG/tmux.conf" "$HOME/.tmux.conf"

source "$HOME/.bashrc"

# uncomment to enable subpackages
default_subpkgs_to_install=(
  "chrome"
  "docker"
  "git"
  "go"
  #" keyboard-shortcuts" not ready
  #"kubernetes"
  "node"
  #"ui"
  #"video"
  "vim"
  "virtualbox"
  "vscode"
)

cache_subpkgs="$(zetup cache get subpkgs)"
if [ -n "${cache_subpkgs}" ]; then
  for f in "$(echo ${cache_subpkgs} | cut -d' ' -f1)" ; do
    bash -c "source $ZETUP_CUR_PKG/pkg-install-fns.sh && source $ZETUP_CUR_PKG/subpkg/$f/use.sh"
  done
else
  for f in "${default_subpkgs_to_install[@]}" ; do
    bash -c "source $ZETUP_CUR_PKG/pkg-install-fns.sh && source $ZETUP_CUR_PKG/subpkg/$f/use.sh"
  done
fi


if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] ; then
  echo 'You might need to run `gnome-shell --replace` to finish snap installations'
fi
