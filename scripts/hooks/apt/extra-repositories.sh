#!/bin/bash
set -e
# Google Chrome
wget -qO- https://dl.google.com/linux/linux_signing_key.pub|sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg>/dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main'|sudo tee /etc/apt/sources.list.d/google-chrome.list>/dev/null
# Mozilla Firefox
wget -qO- https://packages.mozilla.org/apt/repo-signing-key.gpg|sudo gpg --dearmor -o /usr/share/keyrings/packages.mozilla.org.gpg>/dev/null
echo 'deb [signed-by=/usr/share/keyrings/packages.mozilla.org.gpg] https://packages.mozilla.org/apt mozilla main'|sudo tee /etc/apt/sources.list.d/mozilla.list>/dev/null
# KXStudio
wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
sudo apt install ./kxstudio-repos*.deb
rm ./kxstudio-repos*.deb
# Raul Dipeas
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)