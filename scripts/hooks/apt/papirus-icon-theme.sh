#!/bin/bash
set -e
echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main'|sudo tee /etc/apt/sources.list.d/papirus-ppa.list
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/papirus-ppa.gpg
sudo apt update
sudo apt install -y papirus-icon-theme