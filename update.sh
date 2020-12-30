#!/bin/bash

#### Colors ####
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
Light_BLUE='\033[1;34m'
Light_Cyan='\033[1;35m'
BLUE='\033[1;36m'
NC='\033[0m' # No Color
##################

# --- add screensaver
func_screensaver() {
    echo -e "${GREEN}-- Add consoleblank=0 in /boot/cmdline.txt --${NC}"
    echo consoleblank=0 | sudo tee -a /boot/cmdline.txt
	sudo sed -i ':a;N;$!ba;s/\n/ /g' /boot/cmdline.txt 
	sudo apt-get install -y xscreensaver
    echo -e "${Light_BLUE}-- Finished ScreenSaver install-- ${NC}"
}
func_screensaver
sleep 1

# --- enable ssh
func_enable_ssh() {
    echo -e "${GREEN}-- Enable SSH --${NC}"
    sudo systemctl enable ssh
	sudo systemctl start ssh
    echo -e "${Light_BLUE}-- Completed ssh settings-- ${NC}"
}
func_enable_ssh
sleep 1

# --- alias joystick
func_alias_joystick() {
    echo -e "${GREEN}-- Alias joistick --${NC}"
    echo "alias joystick=/opt/joystick/joystick.sh" >> ~/.bashrc
    echo -e "${Light_BLUE}-- Completed alias settings-- ${NC}"
}
func_alias_joystick
sleep 1

# --- install vscode
func_install_vscode(){
    echo -e "${GREEN}-- Install VScode -- ${NC}"
    sudo wget -qO - https://packagecloud.io/headmelted/codebuilds/gpgkey | sudo apt-key add -;
    echo deb https://packagecloud.io/headmelted/codebuilds/raspbian/ jessie main | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get -y install code-oss
    echo -e "${Light_BLUE}-- Finished VScode install-- ${NC}"
}
func_install_vscode
sleep 1

#--- install uhubctl lib 
func_install_uhubctl(){
    echo -e "${GREEN}-- Install uhubctrl -- ${NC}"
    sudo apt-get install libusb-1.0-0-dev
    cd ~/
    git clone https://github.com/mvp/uhubctl
    cd uhubctl
    make
    sudo make install
    echo -e "${Light_BLUE}-- Finished uhubctrl install -- ${NC}"
}
func_install_uhubctl
sleep 1

#--- Enable raspberry pi USB port on/off
func_usb_on_off(){
    echo -e "${GREEN}-- USB port on/off -- ${NC}"
    #sudo sed -i '/_IP=/i sudo uhubctl -l 2 -a 0' /etc/rc.local
    #sudo sed -i '/_IP=/i sleep 1' /etc/rc.local
    sudo sed -i '/_IP=/i sudo uhubctl -l 2 -a 2\n' /etc/rc.local
    # sudo sed -i '$ i\uhubctl -l 2 -a 0' /etc/rc.local
    # sudo sed -i '$ i\sleep 1' /etc/rc.local
    # sudo sed -i '$ i\sudo uhubctl -l 2 -a 1' /etc/rc.local
    echo -e "${Light_BLUE}-- Finished USB port on/off setting-- ${NC}"
    sleep 1
    sudo cat /etc/rc.local
}
func_usb_on_off
sleep 1

# --- git pull
func_git_pull(){
    echo -e "${GREEN}-- Git pull -- ${NC}"
    cd ~/joystick-serial && git pull
    cd ~/joystick-res && git pull
    echo -e "${Light_BLUE}-- Finished git pull --${NC}"
}
func_git_pull
sleep 1



echo -e "${BLUE}-- Finished Update-- ${NC}"