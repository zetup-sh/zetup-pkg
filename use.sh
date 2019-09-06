#!/bin/bash

mkdir -p "$HOME/dev"

. "$ZETUP_CUR_PKG/pkg-install-fns.sh"

if [ -n "$ZETUP_SYSTEM_PASS" ]; then

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
  # install developer tools
  version=$(sw_vers -productVersion|awk -F. '{print $1"."$2}')
  if [ version == "10.9" ]; then
    chk_cmd="pkgutil --pkg-info=com.apple.pkg.CLTools_Executables"
  else
    chk_cmd="xcode-select -p"
  fi
  $chk_cmd 1>/dev/null 2>&1
  if [ $? -ne 0 ]; then
    # https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    PROD=$(softwareupdate -l |
    grep "\*.*Command Line.*$(sw_vers -productVersion|awk -F. '{print $1"."$2}')" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
    softwareupdate -i "$PROD" --verbose
    rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  fi

  # install brew
  if [ ! -x "$(command -v brew)" ]; then
    URL_BREW='https://raw.githubusercontent.com/Homebrew/install/master/install'

    echo -n '- Installing brew ... '
    echo | /usr/bin/ruby -e "$(curl -fsSL $URL_BREW)" > /dev/null
    if [ $? -eq 0 ]; then echo 'OK'; else echo 'NG'; fi
  fi
fi

if [ ! -f "$HOME/.profile" ] && [ ! -f "$HOME/.bash_profile" ] && [ ! -f "$HOME/.bash_login" ]; then
  zetup link "$ZETUP_CUR_PKG/bash/profile.sh" "$HOME/.profile"
fi

brew_pkgs=(
  # your brew packages here
  "wget" # file downloader
  "cask" # another package installer
  "mas" # mac app store cli installer
  "autoconf" "automake" "libtool" # build tools
  "git" # source control (newer version)
  "htop" # system monitor
  "nmap" # security scanner
  "links" # terminal web browser
  "geoip" # geolocation of ip addresses
  "irssi" # irc
  "bash-completion"
  "watch" # watch for changes in output of command
  "tmux" # terminal multiplexer
  "python" # python 3
  "wifi-password" # display wifi password of current network
)
brew_install ${brew_pkgs[@]}

brew_cask_install_pkgs=(
  "iterm2"
)
brew_cask_install ${brew_cask_install_pkgs}

pip_pkgs=(
  "tldr" # abbreviated man pages, community driven
  "jq" # json cli parser
  "yq" # yaml cli parser
  "speedtest-cli"
)
pip_install ${pip_pkgs[@]}

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
  done
else
  for f in "${default_subpkgs_to_install[@]}" ; do
    bash -c "source $ZETUP_CUR_PKG/pkg-install-fns.sh && source $ZETUP_CUR_PKG/subpkg/$f/use.sh"
  done
fi

if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] ; then
  echo 'You might need to run `gnome-shell --replace` to finish snap installations'
fi
