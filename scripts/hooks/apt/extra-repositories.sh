#!/bin/bash
set -e
# Google Chrome
wget -qO- https://dl.google.com/linux/linux_signing_key.pub|gpg --dearmor -o /etc/apt/trusted.gpg.d/google-chrome.gpg>/dev/null
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main'|tee /etc/apt/sources.list.d/google-chrome.list>/dev/null
# KXStudio
wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
apt install ./kxstudio-repos*.deb
rm ./kxstudio-repos*.deb
# MEGA
wget -qO- https://mega.nz/keys/MEGA_signing.key|gpg --dearmor -o /etc/apt/trusted.gpg.d/megasync.gpg>/dev/null
echo 'deb https://mega.nz/linux/repo/Debian_12/ ./'|tee /etc/apt/sources.list.d/megasync.list>/dev/null
# Mozilla Firefox
wget -qO- https://packages.mozilla.org/apt/repo-signing-key.gpg|gpg --dearmor -o /etc/apt/trusted.gpg.d/mozilla.gpg>/dev/null
echo 'deb https://packages.mozilla.org/apt mozilla main'|tee /etc/apt/sources.list.d/mozilla.list>/dev/null
# Raul Dipeas
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)