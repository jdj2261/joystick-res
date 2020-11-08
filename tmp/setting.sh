cd /opt && ln -s /home/pi/joystick-res joystick
echo "lxterminal -e /opt/joystick/joystick.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "## My alias ##" >> ~/.bashrc 
echo "alias vbash='vi ~/.bashrc'" >> ~/.bashrc
echo "alias sbash='source ~/.bashrc'" >> ~/.bashrc
echo "alias ll='ls -al'" >> ~/.bashrc
source ~/.bashrc

