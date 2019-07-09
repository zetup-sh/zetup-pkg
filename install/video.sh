apt install vlc
sed -n '
[Default Applications]
/^video/{
s/Totem/vlc/
s/org\.gnome\.//p
}' /usr/share/applications/defaults.list > ~/.local/share/applications/defaults.list

sudo add-apt-repository ppa:jonathonf/ffmpeg-4
sudo apt install ffmpeg
