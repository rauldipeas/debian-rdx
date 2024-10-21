#!/bin/bash
set -e
am -i walc
cat <<EOF |sudo tee -a /usr/local/share/applications/walc-AM.desktop
StartupWMClass=walc
EOF