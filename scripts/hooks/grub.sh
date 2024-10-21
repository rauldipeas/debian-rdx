#!/bin/bash
set -e
wget -q --show-progress https://github.com/rauldipeas/debian-rdx/raw/main/assets/compressed/debian-1080p.zip
sudo mkdir -p /usr/share/grub/themes
sudo unzip debian-1080p.zip -d /usr/share/grub/themes
sudo rm debian-1080p.zip /usr/share/grub/themes/darkmatter-theme.py
sudo mkdir /etc/default/grub.d
cat <<EOF |sudo tee /etc/default/grub.d/theme.cfg>/dev/null
GRUB_THEME="/usr/share/grub/themes/darkmatter/theme.txt"
GRUB_BACKGROUND=""
EOF