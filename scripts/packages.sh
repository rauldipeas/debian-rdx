#!/bin/bash
set -e
mkdir -p /tmp/debian-rdx/config/includes.chroot/etc/apt/preferences.d
cat <<EOF |tee /tmp/debian-rdx/config/includes.chroot/etc/apt/preferences.d/backports.pref>/dev/null
Package: *
Pin: release n=bookworm-backports
Pin-Priority: -1
EOF
cp scripts/desktop-packages.list /tmp/debian-rdx/config/package-lists/desktop.list.chroot
cd /tmp/debian-rdx/config/packages.chroot
#atuin
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/ellie/atuin/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
dpkg-name atuin*.deb
#micro
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/zyedidia/micro/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)"
dpkg-name micro*.deb
#veracrypt
wget -q --show-progress "$(wget -qO- https://www.veracrypt.fr/en/Downloads.html|grep amd64.deb|head -n1|cut -d '"' -f2|sed 's/&#43;/+/g')"
dpkg-name veracrypt*.deb
#sparkleshare
#wget -q --show-progress https://github.com/rauldipeas/debian-rdx/raw/main/assets/deb/libappindicator3-0.1-cil_12.10.0+git20151221-5.1_amd64.deb
#wget -q --show-progress https://github.com/rauldipeas/debian-rdx/raw/main/assets/deb/libwebkit2-sharp-4.0-cil_2.10.9+git20160917-1.1_amd64.deb
#wget -q --show-progress https://github.com/rauldipeas/debian-rdx/raw/main/assets/deb/sparkleshare_3.28+git20190525+cf446c0-3_all.deb
#waveterm
#xournal++
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/xournalpp/xournalpp/releases|grep browser_download_url|grep -v dev|grep Debian|grep deb|head -n1|cut -d '"' -f4)"
dpkg-name xournalpp*.deb