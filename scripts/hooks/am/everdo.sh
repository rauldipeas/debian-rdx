#!/bin/bash
set -e
am -i everdo
sudo sed -i 's/StartupWMClass=Everdo/StartupWMClass=everdo/g' /usr/local/share/applications/everdo-AM.desktop