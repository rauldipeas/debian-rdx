#!/bin/bash
set -e
am -i everdo
sed -i 's/StartupWMClass=Everdo/StartupWMClass=everdo/' /usr/local/share/applications/everdo-AM.desktop