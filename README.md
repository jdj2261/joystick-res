# 라즈베리파이 셋팅



## 1. wifi 연결

Raspberry Pi Configuration

Localisation -> Wifi Country -> GB(Britain)로 설정



## 2. 한글 설치

~~~
$ sudo apt-get install fonts-unfonts-core
$ sudo apt-get install fcitx-hangul
$ sudo vi /etc/default/im-config
IF_CONFIG_DEFAULT_MODE=fcitx (auto -> fcitx로 변경)
$ reboot
~~~



## 3. 지역설정 및 키보드

Raspberry Pi Configuration

Locale : Korean으로 변경 후 재부팅

오른쪽 상단 키보드 그림 오른쪽 마우스 버튼 클릭

입력방법 한글 추가



## 4. joystick 셋팅

~~~
$ sudo apt-get install git
$ git clone https://github.com/jdj2261/joystick-serial.git
$ git clone https://github.com/jdj2261/joystick-res.git
$ cd joystick-res && ./bootup.sh
~~~



## 5. Serial 활성화

1. raspi-config에서 serial 활성화

   ~~~
   $ sudo raspi-config
     5 Interfacing Options 선택
     P6 Serial 선택
     YES 선택
   ~~~

2. Bluetooth 사용 중지

   ~~~
   $ sudo vi /boot/config.txt
   맨 아래 dtoverlay=pi3-disable-bt 추가
   $ sudo systemctl disable hciuart
   ~~~

3.  disable Console

   ~~~
   $ sudo vi /boot/cmdline.txt
   console=serial0.115200 부분 삭제
   ~~~

4. 결과 확인

   ~~~
   $ ll /dev/serial0
   /dev/serial0 -> ttyAMA0 인지 확인
   ~~~



## 6. joystick Start

~~~
$ cd ~
$ cd joystcik-res && sudo ./setting.sh
$ cd /opt && ll joystick 
$ reboot
~~~



