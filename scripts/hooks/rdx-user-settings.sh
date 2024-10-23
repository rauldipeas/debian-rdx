#!/bin/bash
set -e
sudo mkdir -p /opt/rdx-user-settings/bash
wget -qO /opt/rdx-user-settings/bash/bashrc https://github.com/rauldipeas/debian-rdx/raw/main/settings/bash/bashrc
wget -qO /opt/rdx-user-settings/bash/bash-preexec.sh https://github.com/rcaloras/bash-preexec/raw/master/bash-preexec.sh
wget -qO /opt/rdx-user-settings/bash/atuin.bash https://github.com/rauldipeas/debian-rdx/raw/main/settings/bash/atuin.bash
wget -qO /opt/rdx-user-settings/bash/liquidprompt.bash https://github.com/rauldipeas/debian-rdx/raw/main/settings/bash/liquidprompt.bash
wget -qO /opt/rdx-user-settings/bash/local-bin.bash https://github.com/rauldipeas/debian-rdx/raw/main/settings/bash/local-bin.bash
wget -qO /opt/rdx-user-settings/dconf-settings.ini https://github.com/rauldipeas/debian-rdx/raw/main/settings/dconf-settings.ini
wget -qO /opt/rdx-user-settings/topgrade-config.toml https://github.com/topgrade-rs/topgrade/raw/main/config.example.toml
sed -i 's/# no_self_update/no_self_update/g' /opt/rdx-user-settings/topgrade-config.toml
cat <<EOF |sudo tee /usr/local/share/applications/debianrdx.featurebase.app.desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=preferences-desktop-feedback
Name=User feedback
Name[pt_BR]=Feedback do usuário
Comment=Share your thoughts and help to improve the Debian RDX
Comment[pt_BR]=Compartilhe suas ideias e ajude a melhorar o Debian RDX
Categories=Internet;
Exec=xdg-open https://debianrdx.featurebase.app
EOF
cat <<EOF |sudo tee /etc/profile.d/rdx-user-settings.sh /etc/X11/Xsession.d/90-rdx-user-settings>/dev/null
if ! [ -f "\$HOME"/.rdx-user-settings ];then
    mkdir -p "\$HOME"/.config/systemd
    mkdir -p "\$HOME"/.local/share/applications
    #bash
    mkdir -p "\$HOME"/.bashrc.d
    cp /etc/skel/.bashrc "\$HOME"/.bashrc.d/rc.bash
    cp /opt/rdx-user-settings/bash/bashrc "\$HOME"/.bashrc
    cp /opt/rdx-user-settings/bash/*.bash "\$HOME"/.bashrc.d/
    cp /opt/rdx-user-settings/bash/*.sh "\$HOME"/.bashrc.d/
    cp /usr/share/liquidprompt/liquidpromptrc-dist "\$HOME"/.config/liquidpromptrc
    sed -i 's/debian.theme/powerline.theme/g' "\$HOME"/.config/liquidpromptrc
    #dconf
    dconf load / < /opt/rdx-user-settings/dconf-settings.ini
    #gnome-shell-extensions
    cp -r /opt/rdx-user-settings/gnome-shell "\$HOME"/.local/share/
    #pipewire/pulseaudio
    ln -fs /dev/null "\$HOME"/.config/systemd/pipewire.service
    ln -fs /dev/null "\$HOME"/.config/systemd/pipewire.socket
    #walc
    ln -fs /dev/null "\$HOME"/.local/share/applications/WALC.desktop
    #topgrade
    cp /opt/rdx-user-settings/topgrade-config.toml "\$HOME"/.config/topgrade.toml
    touch "\$HOME"/.rdx-user-settings
fi
EOF
cat <<EOF |sudo tee /etc/environment.d/90-qt-qpa-platformtheme.conf /etc/profile.d/qt-qpa-platformtheme.sh /etc/X11/Xsession.d/90-qt-qpa-platformtheme>/dev/null
export QT_QPA_PLATFORMTHEME=gtk2
EOF
cat <<EOF |sudo tee /etc/rc.local>/dev/null
#!/bin/bash
set -e
chown -R "\$(ls /home)"\
    /opt/am\
    /opt/bat\
    /opt/casterr\
    /opt/everdo\
    /opt/fd\
    /opt/freetube\
    /opt/got\
    /opt/mission-center\
    /opt/muffon\
    /opt/nyrna\
    /opt/rustdesk\
    /opt/squirrel-disk\
    /opt/stretchly\
    /opt/topgrade\
    /opt/walc\
    /opt/zen-browser
rm /etc/rc.local
EOF
sudo chmod +x /etc/rc.local
cat <<EOF |sudo tee /usr/local/bin/reset-user-settings>/dev/null
rm -r "\$HOME"/.rdx-user-settings "\$HOME"/.local/share/gnome-shell
sudo shutdown -r 0
EOF
sudo chmod +x /usr/local/bin/reset-user-settings