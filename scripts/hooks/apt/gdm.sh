#!/bin/bash
set -e
sudo apt install -y git
git clone --depth=1 --single-branch https://github.com/realmazharhussain/gdm-tools
cd gdm-tools
echo y|./install.sh
sudo sed -i 's/IconTheme=Adwaita/Papirus-Dark/g' /usr/share/themes/Adwaita/index.theme
sudo sed -i 's/IconTheme=Adwaita/Papirus-Dark/g' /usr/share/themes/Adwaita-dark/index.theme
set-gdm-theme set default /usr/share/backgrounds/gnome/blobs-d.svg
echo y|./uninstall.sh --purge
cd ..
rm -rf gdm-tools
sudo apt autoremove --purge -y git