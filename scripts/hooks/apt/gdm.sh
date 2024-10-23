#!/bin/bash
set -e
apt install -y git
git clone --depth=1 --single-branch https://github.com/realmazharhussain/gdm-tools
cd gdm-tools
echo y|./install.sh
sed -i 's/IconTheme=Adwaita/Papirus-Dark/' /usr/share/themes/Adwaita/index.theme
sed -i 's/IconTheme=Adwaita/Papirus-Dark/' /usr/share/themes/Adwaita-dark/index.theme
set-gdm-theme set default /usr/share/backgrounds/gnome/blobs-d.svg
echo y|./uninstall.sh --purge
cd ..
rm -rf gdm-tools
apt autoremove --purge -y git