#!/bin/bash

mkdir -p "$HOME/dev"

. "$ZETUP_CUR_PKG/pkg-install-fns.sh"

# allow users to temporarily assign sudo
# password to variable
if [ -n "$ZETUP_SYSTEM_PASS" ]; then
  alias sudo="echo "$ZETUP_SYSTEM_PASS" | sudo -S "
fi

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
  "geoip-bin"
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
  "geoip"
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
  "htop"
  "links"
  "irssi"
)
snap_install ${snap_pkgs[@]}

if [ -x "$(command -v snap)" ] && [ -x "$(command -v htop)" ]; then
  sudo snap connect htop:mount-observe
  sudo snap connect htop:process-control
  sudo snap connect htop:system-observe
  sudo snap connect htop:network-control  # DELAYACCT support (optional)
fi

if [ -x "$(command -v snap)" ] && [ -x "$(command -v nmap)" ]; then
  sudo snap connect nmap:network-control
fi

snap_classic_pkgs=(
  # add your snap --classic packages here
  # "slack"
)
snap_classic_install ${snap_classic_pkgs[@]}

if [ "$(uname)" == "Darwin" ]; then
  . "$ZETUP_CUR_PKG/darwin.sh"
fi

pip_pkgs=(
  "tldr" # abbreviated man pages, community driven
  "jq" # json cli parser
  "yq" # yaml cli parser
  "speedtest-cli"
)
pip_install ${pip_pkgs[@]}

ssh-add $ZETUP_PRIVATE_KEY_FILE  2>/dev/null

zetup link "$ZETUP_CUR_PKG/shell/bashrc.sh" "$HOME/.bashrc"
zetup link "$ZETUP_CUR_PKG/shell/aliases.sh" "$HOME/.aliases"
zetup link "$ZETUP_CUR_PKG/shell/fns.sh" "$HOME/.fns"
zetup link "$ZETUP_CUR_PKG/tmux.conf" "$HOME/.tmux.conf"

source "$HOME/.bashrc"

# uncomment to enable subpackages
default_subpkgs_to_install=(
  "chrome"
  "docker"
  "git"
  "go"
  #" keyboard-shortcuts" not ready
  "kubernetes"
  "node"
  # "ui"
  "video"
  "vim"
  "virtualbox"
  "vscode"
)

cache_subpkgs="$(zetup cache get subpkgs)"
if [ -n "${cache_subpkgs}" ]; then
  for f in "$(echo ${cache_subpkgs} | cut -d' ' -f1)" ; do
    bash -c "source $ZETUP_CUR_PKG/pkg-install-fns.sh && source $ZETUP_CUR_PKG/subpkg/$f/use.sh"
    if [ $? -ne 0 ]; then
      echo "installation of $f failed"
    fi
  done
else
  for f in "${default_subpkgs_to_install[@]}" ; do
    bash -c "source $ZETUP_CUR_PKG/pkg-install-fns.sh && source $ZETUP_CUR_PKG/subpkg/$f/use.sh"
    if [ $? -ne 0 ]; then
      echo "installation of $f failed"
    fi
  done
fi

if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] ; then
  echo 'You might need to run `gnome-shell --replace` to finish snap installations'
fi
