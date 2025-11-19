> UZ801 firmware update

1. Download this two files
- Rootfs:
- Firmware: 

2. Unpack the two .zip files

3. Move the files inside `debian` to `base_generic` folder
```
mv debian/*.img base_generic
```
4. Edit flash.sh inside `base_generic` folder
> copy and paste
```
#!/bin/sh
#
# Copyright (C) 2021-2022 OpenStick Project
# Author : HandsomeYingyan <handsomeyingyan@gmail.com>
#

fastboot erase boot
fastboot flash aboot aboot.bin
fastboot reboot
sleep 5
fastboot oem dump fsc && fastboot get_staged fsc.bin
fastboot oem dump fsg && fastboot get_staged fsg.bin
fastboot oem dump modemst1 && fastboot get_staged modemst1.bin
fastboot oem dump modemst2 && fastboot get_staged modemst2.bin
fastboot erase boot
fastboot reboot bootloader
sleep 5

# Now We Got All Of Them To Rock Linux!
fastboot flash partition gpt_both0.bin
fastboot flash hyp hyp.mbn
fastboot flash rpm rpm.mbn
fastboot flash sbl1 sbl1.mbn
fastboot flash tz tz.mbn
fastboot flash fsc fsc.bin
fastboot flash fsg fsg.bin
fastboot flash modemst1 modemst1.bin
fastboot flash modemst2 modemst2.bin
fastboot flash aboot aboot.bin
fastboot flash cdt sbc_1.0_8016.bin
fastboot erase boot
fastboot erase rootfs
fastboot reboot
sleep 5

echo 'flashing debian os'
fastboot -S 200M flash rootfs rootfs.img
fastboot flash boot boot.img
sleep 5
fastboot reboot

echo 'all done enjoy your debian os!'
```
5. Add permission
```
chmod +x flash.sh
```
6. Enable uz801 adb from browser 
```
192.168.100.1/usbdebug.html
```
6. Start flashing
```
adb reboot bootloader
```
7. Flash
```
./flash.sh
```
8. Terminal access 
```
adb shell
```
9. Connect to a wifi
> example 
```
nmcli dev wifi connect "Asus" password "1234567890"
```
10. Update sources.list
```
rm /etc/apt/sources.list.d/*
```
```
echo > /etc/apt/sources.list
```
```
echo deb http://deb.debian.org/debian bullseye main contrib non-free >> /etc/apt/sources.list
```
```
echo deb http://security.debian.org/debian-security bullseye-security main contrib non-free >> /etc/apt/sources.list
```
```
echo deb http://deb.debian.org/debian bullseye-updates main contrib non-free >> /etc/apt/sources.list
```
11. Install common tools
```
apt update
apt install sudo nano git wget -y
```

# RNDIS
> Replace adb with rndis
```
git clone https://github.com/xiv3r/uz801-debian-bullseye.git
cd uz801-debian-bullseye
chmod +x install.sh
sudo bash install.sh
```
