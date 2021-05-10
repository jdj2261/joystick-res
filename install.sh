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

echo -e "${Light_Cyan}-- Start Joystick Setup --${NC}"
sleep 1

# --- hangul install
func_hangul_install() {
	sudo apt update
	echo -e "${GREEN}Install fcitx-hangul${NC}"
	sudo apt -y install fcitx-hangul
	echo -e "${GREEN}Install fonts-unfonts-core${NC}"
	sudo apt -y install fonts-unfonts-core
	sudo sed -i 's/IM_CONFIG_DEFAULT_MODE=auto/IF_CONFIG_DEFAULT_MODE=fcitx/g' /etc/default/im-config
	sudo sed -i 's/XKBLAYOUT="gb"/XKBLAYOUT="en"/g' /etc/default/keyboard
}
func_hangul_install
echo -e "${Light_BLUE}Finished hangul-pkg install${NC}"
sleep 1
# --- 

# --- setup serial
func_serial_set() {
	echo -e "${GREEN}Enable serial${NC}"
	echo enable_uart=1 | sudo tee -a /boot/config.txt
	echo dtoverlay=pi3-disable-bt | sudo tee -a /boot/config.txt
	sudo systemctl disable hciuart
	sudo sed -i 's/console=serial0,115200//g' /boot/cmdline.txt
}
func_serial_set
echo -e "${Light_BLUE}Finished serial setup${NC}"
sleep 1
# --- 

# --- set joystick-serial, joystick-res
func_joystick_set() {
	echo -e "${GREEN}Install vim${NC}"
	sudo apt -y install vim
	echo -e "${GREEN}Install git${NC}"
	sudo apt -y install git
	echo -e "${GREEN}Install pip3${NC}"
	sudo apt -y install python3-pip
	echo -e "${GREEN}Install gitpython package${NC}"
	pip3 install gitpython
	cd ~
	echo -e "${GREEN}Clone joystick-serial.git & joistck-res.git${NC}"
	git clone https://github.com/jdj2261/joystick-serial.git
	git clone https://github.com/jdj2261/joystick-res.git
	cd ~/joystick-res

	bootup_file=/home/pi/joystick-res/bootup

	if [ -d $bootup_file ]; then
		echo -e "${RED}bootup Directory already exists.${NC}"
	else
		echo -e "${GREEN}Make bootup file & Set soft link.${NC}"
		mkdir bootup && cd bootup && ln -sfn ~/joystick-serial .
	fi

	cd /opt && sudo ln -s /home/pi/joystick-res joystick

	echo -e "${GREEN}Enable Autostart${NC}"
	echo lxterminal -e /opt/joystick/joystick.sh | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart
}
func_joystick_set
echo -e "${Light_BLUE}Finished joystick setup${NC}"
sleep 1

# --- set alias
func_alias_set() {
	echo -e "${GREEN}Set Alias${NC}"
	echo "## My alias ##" >> ~/.bashrc 
	echo "alias vbash='vi ~/.bashrc'" >> ~/.bashrc
	echo "alias sbash='source ~/.bashrc'" >> ~/.bashrc
	echo "alias ll='ls -al'" >> ~/.bashrc
	echo "alias joystick=/opt/joystick/joystick.sh" >> ~/.bashrc
	source ~/.bashrc
}
func_alias_set
echo -e "${Light_BLUE}Finished alias settings${NC}"
sleep 1

# --- add screensaver
func_screensaver() {
    echo -e "${GREEN}-- Add consoleblank=0 in /boot/cmdline.txt --${NC}"
    echo consoleblank=0 | sudo tee -a /boot/cmdline.txt
	sudo sed -i ':a;N;$!ba;s/\n/ /g' /boot/cmdline.txt 
	sudo apt install -y xscreensaver
}
func_screensaver
echo -e "${Light_BLUE}Finished screensaver${NC}"
sleep 1

# --- enable ssh
func_enable_ssh() {
    echo -e "${GREEN}-- Enable SSH --${NC}"
    sudo systemctl enable ssh
	sudo systemctl start ssh
}
func_enable_ssh
sleep 1

# --- install vscode (code-oss)
func_install_vscode(){
    echo -e "${GREEN}-- Install VScode -- ${NC}"
    sudo apt update
    sudo apt -y install code
    echo -e "${Light_BLUE}-- Finished VScode install-- ${NC}"
}
func_install_vscode
sleep 1

#--- install uhubctl lib 
func_install_uhubctl(){
    echo -e "${GREEN}-- Install uhubctrl -- ${NC}"
    sudo apt install -y libusb-1.0-0-dev
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
    sudo sed -i '/_IP=/i sudo uhubctl -l 1-1 -a 0' /etc/rc.local
    sudo sed -i '/_IP=/i sleep 1' /etc/rc.local
    sudo sed -i '/_IP=/i sudo uhubctl -l 1-1 -a 2' /etc/rc.local
    # sudo sed -i '/_IP=/i sudo uhubctl -l 2 -a 2\n' /etc/rc.local

    echo -e "${Light_BLUE}-- Finished USB port on/off setting-- ${NC}"
    sleep 1
    sudo cat /etc/rc.local
}
func_usb_on_off

echo -e "${BLUE}-- Finished Update-- ${NC}"
sleep 1

echo -e "${BLUE}-- Reboot...${NC}"
sleep 3
sudo reboot
# --- 
