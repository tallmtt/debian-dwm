#!/bin/bash

# Add a menu of software to include
### See: https://gijs-de-jong.nl/posts/pretty-dialog-boxes-for-your-shell-scripts-using-whiptail/#checklist-box
## DE + lightdm (dwm, cinammon, etc)
## Editing (gimp, audacity, video??, libreoffice, emacs)
## Intel vs AMD??
## Internet (Firefox, IRC, Thunderbird, etc)
## Virtualizing? (virtualbox)
## Entertainment (vlc, mpd, mpc)
## Other (keepassxc, nextcloud-desktop, joplin, chess)

# xorg display server installation
sudo apt install -y xorg

# Microcode for Intel/AMD 
# sudo apt install -y amd-microcode
sudo apt install -y intel-microcode 

# File Manager (eg. pcmanfm, thunar, ranger)
sudo apt install -y ranger

# Sound packages
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa

# Neofetch/HTOP
sudo apt install -y neofetch htop

# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa --header --color=always --group-directories-first'
sudo apt install -y exa

# Browser Installation (eg. chromium, firefox-esr)
sudo apt install -y firefox-esr 

# Install emacs
sudo apt install -y emacs

# Install wireguard
sudo apt install -y wireguard

# Install joplin

# Install Virtualbox

# Install gimp
sudo apt install -y gimp

# Install picom X-org compositor
# Use https://wiki.archlinux.org/title/Picom for information on use
sudo apt install -y picom

# Install pandoc
sudo apt install -y pandoc

# Install LibreOffice
sudo apt install -y libreoffice

# Install hledger
sudo apt install -y hledger hledger-ui hledger-web

# Install 
# Install suckless stuff
## git clone suckless
## download requirements
## build them all

### Dwm stuff

# Install dwm/dmenu/st/slstatus requirements
sudo apt install -y build-essential libx11-dev libxft-dev libxinerama-dev libfreetype6-dev libfontconfig1-dev fonts-font-awesome libpam0g-dev libxcb-xkb-dev

# Desktop background browser/handler 
# feh --bg-fill /path/to/directory 
# example if you want to use in autostart
# sudo apt install -y nitrogen 
sudo apt install -y feh

# Install suckless dwm - dynamic window manager
cd
mkdir Downloads
cd Downloads
git clone  git@github.com:tallmtt/MR-dwm.git
#https://github.com/rendiwijiatmoko/dwm.git
cd dwm
sudo make clean install

# Install suckless st - simple terminal
cd
mkdir Downloads
cd Downloads
git clone git@github.com:tallmtt/MR-st.git
#https://github.com/rendiwijiatmoko/st.git
cd st
sudo make clean install

# Install suckless dmenu - dynamic manu
cd
mkdir Downloads
cd Downloads
git clone  git@github.com:tallmtt/MR-dmenu.git
#https://github.com/rendiwijiatmoko/dmenu.git
cd dmenu
sudo make clean install

# Surf

# Dependencies for Ly Console Manager
# Install Ly Console Display Manager
#cd 
#cd Downloads
#git clone --recurse-submodules git@github.com:fairyglade/ly.git
##https://github.com/nullgemm/ly.git
#cd ly/
#make
#sudo make install
#sudo systemctl enable ly

# Install suckless slstatus
cd
mkdir Downloads
cd Downloads
git clone git://git.suckless.org/slstatus
cd slstatus
sudo make clean install

# XSessions and dwm.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp

sudo apt autoremove

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"
