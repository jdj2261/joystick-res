bootup_file=/home/pi/joystick-res/bootup

if [ -d $bootup_file ]; then
	echo "bootup Directory already exists."
else
	mkdir bootup && cd bootup && ln -sfn ~/joystick-serial .
	echo "make bootup file & set soft link"
fi
