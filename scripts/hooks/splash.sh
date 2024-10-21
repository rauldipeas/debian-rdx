#!/bin/bash
set -e
find . -name "*splash*" -delete
wget -q --show-progress https://github.com/rauldipeas/debian-rdx/raw/main/assets/compressed/debian-1080p.zip
sudo unzip debian-1080p.zip -d boot/grub/themes
sudo rm debian-1080p.zip boot/grub/themes/darkmatter-theme.py
sudo mkdir -p boot/grub/fonts
sudo cp boot/grub/themes/darkmatter/*.pf2 boot/grub/fonts/
sudo sed -i 's@Live system@Debian GNU/Linux live@g' boot/grub/grub.cfg isolinux/live.cfg
sudo sed -i 's/(amd64)//g' boot/grub/grub.cfg isolinux/live.cfg
sudo sed -i 's/(amd64 /(/g' boot/grub/grub.cfg isolinux/live.cfg
cat <<EOF |sudo tee boot/grub/theme.cfg>/dev/null
set color_normal=light-gray/black
set color_highlight=white/dark-gray
set gfxmode=auto
loadfont hackb_18
loadfont norwester_16
loadfont norwester_20
loadfont norwester_22
set theme=/boot/grub/themes/darkmatter/theme.txt
EOF