#!/bin/bash -e
echo -e '\e[1m\e[92m-- START --\033[0m'

# --- hangul install
func_hangul_install() {
	sudo apt-get install fcitx-hangul
	sudo apt-get install fonts-unfonts-core
	sudo sed -i 's/IM_CONFIG_DEFAULT_MODE=auto/IF_CONFIG_DEFAULT_MODE=fcitx/g' /etc/default/im-config
	sudo sed -i 's/XKBDLAYOUT="gb"/XKBDLAYOUT="en"/g' /etc/default/keyboard
}
func_hangul_install
echo -e '\e[1m\e[92minstall hangul-pkg\033[0m'
# --- 

# --- setup serial
func_serial_set() {
	sudo echo "enable_uart=1" >> /boot/config.txt
	sudo echo "dtoverlay=pi3-disable-bt" >> /boot/config.txt
	sudo systemctl disable hciuart
	sudo sed -i 's/console=serial0,115200//g' /boot/cmdline.txt
}
func_serial_set
echo -e '\e[1m\e[92mfinished serial setup\033[0m'
# --- 

func_joystick_set() {
	sudo apt-get install vim
	sudo apt-get install git
	cd ~
	git clone https://github.com/jdj2261/joystick-serial.git
	git clone https://github.com/jdj2261/joystick-res.git
	
	cd ~/joystick-res

	bootup_file=/home/pi/joystick-res/bootup

	if [ -d $bootup_file ]; then
		echo "bootup Directory already exists."
	else
		mkdir bootup && cd bootup && ln -sfn ~/joystick-serial .
		echo "make bootup file & set soft link"
	fi

	cd /opt && ln -s /home/pi/joystick-res joystick
	echo "lxterminal -e /opt/joystick/joystick.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart
	echo "## My alias ##" >> ~/.bashrc 
	echo "alias vbash='vi ~/.bashrc'" >> ~/.bashrc
	echo "alias sbash='source ~/.bashrc'" >> ~/.bashrc
	echo "alias ll='ls -al'" >> ~/.bashrc
}
func_joystick_set
echo -e '\e[1m\e[92mfinished joystick setup\033[0m'

source ~/.bashrc
# --- 





