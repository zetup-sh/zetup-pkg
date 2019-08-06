#!/bin/bash
# probably needs a lot of work
mkdir ~/background
cd ~/background

curl -L -O "https://cdna.artstation.com/p/assets/images/images/002/120/516/large/alena-aenami-for-y1900.jpg?1457535992"

mv alena-aenami-for-y1900.jpg?1457535992 alena-aenami-for-y1900.jpg

xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set $PWD/alena-aenami-for-y1900.jpg


