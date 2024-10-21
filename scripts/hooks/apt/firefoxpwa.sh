#!/bin/bash
set -e
wget -qO- https://packagecloud.io/filips/FirefoxPWA/gpgkey|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/firefoxpwa-keyring.gpg>/dev/null
echo 'deb https://packagecloud.io/filips/FirefoxPWA/any any main'|sudo tee /etc/apt/sources.list.d/firefoxpwa.list>/dev/null
sudo apt update
sudo apt install -y --no-install-recommends firefoxpwa