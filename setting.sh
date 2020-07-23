cd /opt && ln -s /home/pi/joystick-res joystick
echo "lxterminal -e /opt/joystick/joystick.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart
