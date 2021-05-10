# Raspberry Pi 3 Settings

TRIGGER ELITE joystick serial data transmission using Raspberry Pi 3

By DJ Jin

- Reference materials(address)
  - Raspberry Pi OS install  ➡ [참고](https://www.raspberrypi.org/downloads/raspberry-pi-os/)
  - Wifi connection ➡ [참고](https://www.withover.com/2018/08/wifi.html)
  - Hangul Install ➡ [참고](https://sm987.blogspot.com/2018/12/fcitx-im-config.html, https://alwt.tistory.com/78)
  - Joystick ➡ [참고](https://github.com/jdj2261/joystick-serial.git)
  - Serial ➡ [참고](https://luciferd.tistory.com/entry/Raspberry-Uart-사용방법)
  - Auto reboot ➡ [참고](https://frogbam07.tistory.com/1)
  - Canceling sleep mode ➡ [참고](https://geeksvoyage.com/raspberry%20pi/turn-off-screen-blanking)



## 1. wifi connection

Raspberry Pi Configuration

Localisation -> Wifi Country -> GB(Britain)



## 2. Hangul Install

~~~
$ sudo apt-get install fonts-unfonts-core
$ sudo apt-get install fcitx-hangul
$ sudo vi /etc/default/im-config
IF_CONFIG_DEFAULT_MODE=fcitx (auto -> fcitx change)
$ reboot
~~~



## 3. Regional Settings and Keyboard

Raspberry Pi Configuration

Change to Locale: **Korean** and reboot

Picture of the upper right keyboard Right mouse button

Input method Korean added



## 4. joystick setting

~~~
$ sudo apt-get install git
$ git clone https://github.com/jdj2261/joystick-serial.git
$ git clone https://github.com/jdj2261/joystick-res.git
~~~



## 5. Serial Activation

1. Enable serial in **raspi-config**

   ~~~
   $ sudo raspi-config
     5 Interfacing Options Choose
     P6 Serial Choose
     YES Choose
   ~~~

2. Disable Bluetooth

   ~~~
   $ sudo vi /boot/config.txt
   dtoverlay=pi3-disable-bt Bottom Add
   $ sudo systemctl disable hciuart
   ~~~

3. disable Console

   ~~~
   $ sudo vi /boot/cmdline.txt
   console=serial0.115200 Deletion
   ~~~

4. 결과 확인

   ~~~
   $ ll /dev/serial0
   make sure /dev/serial0 -> ttyAMA0
   ~~~



## 6. joystick Start

~~~
$ cd ~
$ /opt/joystick/joystick.sh  or $ joystick
~~~


## 7. Auto Install Script

~~~
$ ./install.sh
~~~
