#!/bin/bash
set -e
am -i casterr
sudo sed -i 's/StartupWMClass=Casterr/StartupWMClass=casterr/g' /usr/local/share/applications/casterr-AM.desktop