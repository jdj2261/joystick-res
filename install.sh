#!/bin/bash
echo -e '\e[1m\e[92m-- START --\033[0m'

# --- hangul install
func_hangul_install() {
	echo -e '\e[1m\e[92mfcitx-hangul install\033[0m'
	sudo apt-get -y install fcitx-hangul
	echo -e '\e[1m\e[92mfonts-unfonts-core install\033[0m'
	sudo apt-get -y install fonts-unfonts-core
	sudo sed -i 's/IM_CONFIG_DEFAULT_MODE=auto/IF_CONFIG_DEFAULT_MODE=fcitx/g' /etc/default/im-config
	sudo sed -i 's/XKBLAYOUT="gb"/XKBLAYOUT="en"/g' /etc/default/keyboard
}
func_hangul_install
echo -e '\e[1m\e[92mfinished hangul-pkg install\033[0m'
# --- 

# --- setup serial
func_serial_set() {
	echo enable_uart=1 | sudo tee -a /boot/config.txt
	echo dtoverlay=pi3-disable-bt | sudo tee -a /boot/config.txt
	sudo systemctl disable hciuart
	sudo sed -i 's/console=serial0,115200//g' /boot/cmdline.txt
}
func_serial_set
echo -e '\e[1m\e[92mfinished serial setup\033[0m'
# --- 

func_joystick_set() {
	echo -e '\e[1m\e[92mvim install\033[0m'
	sudo apt-get -y install vim
	echo -e '\e[1m\e[92mgit install\033[0m'
	sudo apt-get -y install git
	cd ~
	echo -e '\e[1m\e[92joystick git clone\033[0m'
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

	cd /opt && sudo ln -s /home/pi/joystick-res joystick
	echo lxterminal -e /opt/joystick/joystick.sh | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart
	echo "## My alias ##" >> ~/.bashrc 
	echo "alias vbash='vi ~/.bashrc'" >> ~/.bashrc
	echo "alias sbash='source ~/.bashrc'" >> ~/.bashrc
	echo "alias ll='ls -al'" >> ~/.bashrc
	source ~/.bashrc
}
func_joystick_set
echo -e '\e[1m\e[92mfinished joystick setup\033[0m'

echo -e '\e[1m\e[92mReboot...\033[0m'
sleep 3
sudo reboot
# --- 





