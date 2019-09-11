#!/bin/bash

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

# add dock defaults
# todo: add a backup/restore option
dock_apps_mac=(
  "iTerm"
  "Google Chrome"
  "Visual Studio Code"
)
for app in $dock_apps_mac; do
  if [ -d "/Applications/${app}.app" ]; then
    if defaults read com.apple.dock | grep -qv "${app}.app"; then
      defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${app}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";
    fi
  fi
done
killall Dock