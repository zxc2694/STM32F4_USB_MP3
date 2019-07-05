Just raw copy and edit from Benjamin Project(http://vedder.se/2012/12/stm32f4-discovery-usb-host-and-mp3-player/).
This code implement MP3 player via USB HOST using STM32-Discovery Board. 
Compile it under windows, setting correct PATH ARM-GCC first.


1. Install compiler and tool:
```
 - sudo apt-get install gcc-arm-none-eabi

 - sudo apt-get install automake* libtool libusb-1.0-0-dev
```
2. Install st-link:
```
 - git clone https://github.com/texane/stlink.git
 
 - cd stlink
 
 - git checkout -b c722056 c722056
 
 - ./autogen.sh
 
 - ./configure --prefix=/usr
 
 - make
 
 - sudo make install
 
 - sudo cp 49-stlinkv2.rules /etc/udev/rules.d/
 
```
3. Install openocd:
```
 - https://github.com/ntfreak/openocd
 
 - cd openocd
 
 - ./bootstrap
 
 - ./configure --prefix=/usr/local  --enable-jlink --enable-amtjtagaccel --enable-buspirate  --enable-stlink   --disable-libftdi
 
 - echo -e "all:\ninstall:" > doc/Makefile
 
 - make
 
 - sudo make install
```

4. Burn to board:
```
 - make
 
 - sudo make flash
