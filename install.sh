#!/bin/bash

# Add a menu of software to include
### See: https://gijs-de-jong.nl/posts/pretty-dialog-boxes-for-your-shell-scripts-using-whiptail/#checklist-box
###      https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
### Might need: $ TERM=ansi whiptail --title "Welcome Message" --infobox "Howdy, Welcome to OSTechnix.." 8 78
## Bash scripting help: https://linuxize.com/post/bash-functions/
## DE + lightdm (dwm, cinammon, etc)
## Editing (gimp, audacity, video: flowblade, libreoffice, emacs)
## Intel vs AMD??
## Internet (Firefox, IRC, Thunderbird, etc)
## Virtualizing? (virtualbox)
# - [ ] dwm needs to make virtualbox float
## Entertainment (vlc, mpd, mpc)
## python stuff (pywal, jupyter, lektor, django, pip/pipx)
## Other (keepassxc, nextcloud-desktop, joplin, chess)

clear

## Define all functions first
#hello_world () {
#    echo 'Hello World!'
#}

## Functions after Proceeding: choose what to install (y/n)
base_stuff () {

TERM=ansi whiptail --title "Installing Base Things" --msgbox "Installing base packages needed for this setup... \n - Windowing: xorg lightdm \n - CPU: microcode (amd/intel) \n - Sound: pulseaudio alsa-utils pavucontrol volumeicon-alsa \n - Network: network-manager \n - neofetch \n - htop \n - exa \n" 15 78
#TERM=ansi whiptail --title "Installing Base Things" --infobox "Installing base packages needed for this setup..." 8 78

clear

#####################
## Install base stuff
#####################

# xorg display server installation
echo "Installing xorg..."
sudo apt install -y xorg

# Microcode for Intel/AMD
#echo "Installing amd-microcode..."
# sudo apt install -y amd-microcode
echo "Installing intel-microcode..."
#sudo apt install -y intel-microcode

# Sound packages
echo "Installing Sound packages..."
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa

# Network Manager
echo "Installing Network Manager..."
sudo apt install -y network-manager

# Neofetch/HTOP
echo "Installing neofetch and htop"
sudo apt install -y neofetch htop

# EXA installation
# replace ls command in .bashrc file with line below
# - [ ] TODO: alias ls='exa --header --color=always --group-directories-first'
echo "Installing exa..."
sudo apt install -y exa

echo "Installing Display Manager..."
sudo apt install -y lightdm

} # End base stuff


suckless_stuff () {

    TERM=ansi whiptail --title "Suckless" --msgbox "Installing Suckless Stuff \n - Utilities: picom, feh \n - Build requirements: build-essential libx11-dev libxft-dev libxinerama-dev libfreetype6-dev libfontconfig1-dev fonts-font-awesome libpam0g-dev libxcb-xkb-dev \n - dwm \n - dmenu \n - st \n - slstatus" 30 78

## --------------------##

# Install suckless stuff

# Install picom X-org compositor
# Use https://wiki.archlinux.org/title/Picom for information on use
echo "Installing picom..."
sudo apt install -y picom

## Desktop background browser/handler 
# feh --bg-fill /path/to/directory # example if you want to use in autostart
sudo apt install -y feh

## Install dwm/dmenu/st/slstatus requirements
sudo apt install -y build-essential libx11-dev libxft-dev libxinerama-dev libfreetype6-dev libfontconfig1-dev fonts-font-awesome libpam0g-dev libxcb-xkb-dev libharfbuzz-dev

## Clone suckless tools and configs
    mkdir -p ~/.local/src # create any intermediate directories that don't exist;
    cd ~/.local/src
    GIT_SSH_COMMAND="ssh -i ~/.ssh/vh" git clone git@github.com:tallmtt/suckless.git

### Dwm stuff
echo "Installing dwm and suckless tools..."

## Copy color files for default wallpaper/colors
mkdir -p ~/.cache/wal
cp -v suckless/configs/colors-wal-dwm.h ~/.cache/wal
cp -v suckless/configs/colors-wal-st.h ~/.cache/wal
cp -v suckless/configs/colors-wal-dmenu.h ~/.cache/wal
cp -v ~/.local/src/suckless/configs/fehbg ~/.config/dwm/fehbg
mkdir -p ~/Pictures/Wallpaper
cp -v ~/.local/src/suckless/configs/Ibis.jpg ~/Pictures/Wallpapers/Ibis.jpg

## Install suckless dwm - dynamic window manager
cd suckless/dwm-6.3
#sudo make clean install

# Install suckless dmenu - dynamic manu
cd ../dmenu-5.2
#sudo make clean install

# Install suckless slstatus
cd ../slstatus
#sudo make clean install

# Install suckless st - simple terminal
cd ../st-0.8.5
#sudo make clean install

## XSessions and dwm.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

## Move autostart items for dwm
mkdir -p ~/.config/dwm
## link autostart script for dwm autostart plugin
ln -s ~/.local/src/suckless/configs/autostart.sh ~/.config/dwm/autostart.sh
## cp dwm desktop file to xsessions so lightdm can start dwm (through executing the autostart script)
sudo cp ~/.local/src/suckless/configs/dwm.desktop /usr/share/xsessions

## Old way:
#cat > ./temp << "EOF"
#[Desktop Entry]
#Encoding=UTF-8
#Name=dwm
#Comment=Dynamic window manager
#Exec=/home/tallmtt/.config/dwm/autostart.sh
#Icon=dwm
#Type=XSession
#EOF
#sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp

## At this time, should boot up into dwm

} # End Suckless Stuff

tool_stuff () {

TERM=ansi whiptail --title "Installing Tool Stuff" --msgbox "Installing packages of tools...\n - Audio tools: ffmpeg, easytag, audacity, qmmp, cmus, lmms \n - Document tools: emacs, libreoffice, joplin, pandoc \n - File Management: PCmanFM, ranger \n - Image tools: gimp, inkscape, imagemagick \n - Network: Firefox, Nextcloud, Wireguard, Neomutt \n - Other: hledger, virtualbox, keepassxc \n - Video tools: flowblade \n" 30 78

: `
- Audio tools: ffmpeg, easytag, audacity, qmmp, cmus, lmms \n
- Document tools: emacs, libreoffice, joplin, pandoc \n
- File Management: PCmanFM, ranger \n
- Image tools: gimp, inkscape, imagemagick \n
- Network: Firefox, Nextcloud, Wireguard, Neomutt \n
- Other: hledger, virtualbox, keepassxc \n
- Video tools: flowblade \n
`

## Network Tools ##

# Browser Installation (eg. chromium, firefox-esr)
echo "Installing firefox..."
sudo apt install -y firefox-esr

# Install Nextcloud Desktop
echo "Installing Nextcloud Desktop..."
sudo apt install -y nextcloud-desktop

# Install wireguard
echo "Installing wireguard..."
sudo apt install -y wireguard

# Install neomutt
echo "Installing neomutt..."
sudo apt install -y neomutt

#####

## Document Tools ##

# Install emacs
echo "Installing emacs..."
sudo apt install -y emacs
ln -s ~/.local/src/suckless/configs/emacs-config ~/.emacs

# Install LibreOffice
echo "Installing libreoffice..."
sudo apt install -y libreoffice

# Install joplin
echo "Installing Joplin..."
#wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# Install pandoc
echo "Installing pandoc..."
sudo apt install -y pandoc

#####

## Image Tools ##

# Install ImageMagick
echo "Installing ImageMagick..."
sudo apt install -y imagemagick

# Install gimp
echo "Installing gimp..."
sudo apt install -y gimp

# Install inkscape
echo "Installing inkscape..."
sudo apt install -y inkscape

#####

## File Management ##

# File Manager (eg. pcmanfm, thunar, ranger)
echo "Installing ranger filemanager..."
sudo apt install -y ranger

# File Manager (eg. pcmanfm, thunar, ranger)
echo "Installing pcmanfm filemanager..."
sudo apt install -y pcmanfm

#####

## Other Tools ##

# Install Virtualbox
echo "Installing virtualbox..."
sudo apt install -y virtualbox

# Install keepassxc
echo "Installing KeePassXC..."
sudo apt install -y keepassxc

# Install hledger
echo "Installing hledger..."
sudo apt install -y hledger hledger-ui hledger-web

#####

## Video Tools ##

# Install flowblade (video)
echo "Installing flowblade..."
sudo apt install -y flowblade

#####

## Audio Tools ##

# Install ffmpeg, easytag, audacity, qmmp, cmus, lmms
echo "Installing Audio Tools..."
sudo apt install -y ffmpeg easytag audacity qmmp cmus lmms

#####

## Python Stuff ##
# Install Python Stuff
echo "Installing Python Stuff (lektor, jupyter, pywal)..."
sudo apt install -y python3-pip python3-venv
#python3 -m pip install --user pipx
#python3 -m pipx ensurepath
#python3 -m pipx install pywal
#python3 -m pipx install lektor
#python3 -m pipx install notebook

} # End Tools Stuff


## Welcome...
#TERM=ansi whiptail --title "Welcome Message" --msgbox "Howdy, Let's set up your new Debian environment!" 8 78 
#TERM=ansi whiptail --title "CONFIRMATION" --yesno "Should I proceed" 8 78 

TERM=ansi whiptail --title "Minimal Debian: Post Install" --yesno "Let's set up your new Debian environment! Proceed?" 8 78

if [[ $? -eq 0 ]]; then
    ## get ssh keys for suckless git
#    gpg git.tgz.gpg
#    tar zxvf git.tgz
#    cp -vi git/vh* ~/.ssh/
#    rm -r git.tgz git
    base_stuff ## Calling the Base Stuff Install function
    suckless_stuff  ## Install Suckless
    tool_stuff ## Install Tools
elif [[ $? -eq 1 ]]; then
  whiptail --title "MESSAGE" --msgbox "Cancelling Process since user pressed <NO>." 8 78 
elif [[ $? -eq 255 ]]; then
  whiptail --title "MESSAGE" --msgbox "User pressed ESC. Exiting the script" 8 78 
fi

echo "Cleaning up..."
sudo apt autoremove

#clear

printf "\e[1;32mYou can now reboot! Have Fun!\e[0m\n"
