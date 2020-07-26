bootup_file="/home/pi/joystick-res/bootup"

if[-f $bootup_file];then
	echo"bootup File is exists."

mkdir bootup && cd bootup && ln -sfn ~/joystick-serial .
echo "make bootup file & set soft link"
