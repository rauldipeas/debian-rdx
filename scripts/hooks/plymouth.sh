#!/bin/bash
set -e
wget -q --show-progress https://github.com/rauldipeas/debian-rdx/raw/main/assets/compressed/debian-mac-style.zip
unzip debian-mac-style.zip
rm debian-mac-style.zip
sudo cp -R debian-mac-style /usr/share/plymouth/themes/
rm -r debian-mac-style
sudo plymouth-set-default-theme -R debian-mac-style
sudo update-initramfs -u
mkdir -p /etc/systemd/system/display-manager.service.d
cat <<EOF |sudo tee /etc/systemd/system/display-manager.service.d/plymouth.conf>/dev/null
[Unit]
Conflicts=plymouth-quit.service
After=plymouth-quit.service rc-local.service plymouth-start.service systemd-user-sessions.service
OnFailure=plymouth-quit.service

[Service]
ExecStartPost=-/usr/bin/sleep 30
ExecStartPost=-/usr/bin/plymouth quit --retain-splash
EOF