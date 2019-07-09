addshortcut() {
  name=$1
  cmd=$2
  binding=$3
  if ([ -z "$name"  || -z "$cmd" ]) || -z "$binding"
  then
    echo "Usage: addshortcut [name] [command] [binding]"
    echo "the command for the binding, and the binding itself. "
    echo ""
    echo "Example:"
    echo "addshortcut browser \"xdg-open https://google.com\" \"\<Ctrl\>\<Alt\>w\""
    echo "Don\'t for get the quotation marks!"
  fi

  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$name/']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name $name
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command $cmd
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding $binding
}
