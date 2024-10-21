#!/bin/bash
set -e
sudo dpkg --add-architecture i386
cat <<EOF |sudo tee /etc/apt/apt.conf.d/100keep-edited-files>/dev/null
Dpkg::Options {
   "--force-confdef";
   "--force-confold";
}
EOF
sudo apt update