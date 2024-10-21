#!/bin/bash
set -e
sudo apt autoremove --purge -y linux-image* linux-headers*
sudo apt install -t bookworm-backports -y linux-image-amd64 linux-headers-amd64