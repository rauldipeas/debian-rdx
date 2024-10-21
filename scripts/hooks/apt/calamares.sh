#!/bin/bash
set -e
sudo apt install -o Dpkg::Options::="--force-confold" --no-install-recommends -y calamares calamares-settings-debian
sudo sed -i 's/pkexec/sudo -E/g' /usr/bin/install-debian
sudo sed -i 's/calamares-settings-debian/calamares/g' /etc/calamares/modules/packages.conf
sudo sed -i "s/  - sources-final/  - sources-final\n  - shellprocess/g" /etc/calamares/settings.conf 
sudo sed -i "s/        - root/        - root\n        - internet/g" /etc/calamares/settings.conf 
sudo sed -i 's/1/2/g' /etc/calamares/modules/welcome.conf
sudo sed -i 's/true/false/g' /etc/calamares/modules/welcome.conf
sudo sed -i 's/main non-free-firmware/contrib main non-free non-free-firmware/g' /usr/sbin/sources-final
sudo sed -i 's/deb-src/#deb-src/g' /usr/sbin/sources-final
sudo sed -i 's/welcomeStyleCalamares: true/welcomeStyleCalamares: false/g' /etc/calamares/branding/debian/branding.desc
sudo sed -i 's/windowExpanding: normal/windowExpanding: noexpand/g' /etc/calamares/branding/debian/branding.desc
sudo sed -i 's/windowSize: 800px,520px/windowSize: 800px,750px/g' /etc/calamares/branding/debian/branding.desc
sudo cp /usr/share/icons/Papirus/64x64/apps/org.linux_hardware.hw-probe.svg /etc/skel/.face
sudo wget -q --show-progress -O /etc/calamares/branding/debian/welcome.png https://github.com/rauldipeas/debian-rdx/raw/main/assets/calamares-welcome.png
cat <<EOF |sudo tee /etc/calamares/modules/locale.conf>/dev/null
geoip:
    style:    "json"
    url:      "https://geoip.kde.org/v1/calamares"
    selector: ""  # leave blank for the default
EOF
cat <<EOF |sudo tee /etc/calamares/modules/partition.conf>/dev/null
userSwapChoices:
    - none      # Create no swap, use no swap
    - file      # To swap file instead of partition
initialSwapChoice: file
availableFileSystemTypes:  ["xfs","ext4","f2fs"]
defaultFileSystemType: "xfs"
EOF
cat <<EOF |sudo tee /usr/sbin/gpu-driver>/dev/null
#!/bin/bash
set -e
if [ "\$(cut -d' ' -f9 <(grep NVIDIA <(sudo lshw -C display)))" == NVIDIA ];then
    sudo apt install -y -t bookworm-backports firmware-misc-nonfree nvidia-driver
    echo 'NVIDIA'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep AMD <(sudo lshw -C display)))" == AMD ];then
    echo 'AMD'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep Intel <(sudo lshw -C display)))" == Intel ];then
    echo 'Intel'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep VirtualBox <(sudo lshw -C display)))" == VirtualBox ];then
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ \$(lsb_release -cs)-fasttrack main contrib"|sudo tee /etc/apt/sources.list.d/fasttrack.list>/dev/null
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ \$(lsb_release -cs)-backports-staging main contrib"|sudo tee -a /etc/apt/sources.list.d/fasttrack.list>/dev/null
    sudo apt install -y fasttrack-archive-keyring
    sudo apt update
    sudo apt install --no-install-recommends -y virtualbox-guest-x11
    echo 'VirtualBox'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
fi
EOF
cat <<EOF |sudo tee /usr/sbin/power-manager>/dev/null
if find /sys/class/power_supply|grep BAT;then
	sudo apt install -y tlp
fi
EOF
sudo chmod +x /usr/sbin/gpu-driver
cat <<EOF |sudo tee /etc/calamares/modules/shellprocess.conf>/dev/null
dontChroot: false
script:
    - command: "/usr/sbin/gpu-driver"
      timeout: 180
    - command: "/usr/sbin/power-manager"
      timeout: 180
    - "rm -r /etc/calamares"
EOF
sudo chmod +x /usr/sbin/power-manager
cat <<EOF |sudo tee /etc/live/config.conf.d/debian-rdx.conf>/dev/null
LIVE_HOSTNAME=debian-rdx
LIVE_USERNAME=tux
LIVE_USER_FULLNAME="Tux"
#LIVE_LOCALES=pt_BR.UTF-8
#LIVE_KEYBOARD_LAYOUTS=br
EOF