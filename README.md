# realsense-install-linux

## reference

### librealsense
- offical
- [github install](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation.md)
- [github distribution linux](https://github.com/IntelRealSense/librealsense/blob/development/doc/distribution_linux.md)
- [realsense sdk install](https://software.intel.com/sites/products/realsense/sdk/getting_started.html#Installing_the_SDK)
- issue
- [Error running RealSense D435 on Ubuntu 16.04(4.4.0-131-generic)](https://stackoverflow.com/questions/51940928/error-running-realsense-d435-on-ubuntu-16-044-4-0-131-generic)
- [RuntimeError: No device connected](https://github.com/IntelRealSense/librealsense/issues/962)
- [Realsense D435 install](https://blog.csdn.net/u012177641/article/details/80888578)
- [Realsense SR300 install](https://blog.csdn.net/z17816876284/article/details/79159518)
- [github wrapper opencv](https://github.com/IntelRealSense/librealsense/tree/master/wrappers/opencv)
- skill
- [Converting depth into 3D world coordinates intel real sense](https://software.intel.com/en-us/forums/realsense/topic/560784)
- [About world coordinates of D435 in realsense-viewer](https://github.com/IntelRealSense/librealsense/issues/2317)
- [Transforming pixel from a depth image to world coordinates](https://github.com/IntelRealSense/librealsense/issues/1904)
- [How to measure correctly](https://github.com/IntelRealSense/librealsense/issues/1788)
- [github realsense samples](https://github.com/IntelRealSense/realsense_samples)
- [Point Cloud Library](http://docs.pointclouds.org/trunk/)
- [Single Gaussian Background Model 1](http://blog.51cto.com/underthehood/484191)
- [Single Gaussian Background Model 2](https://blog.csdn.net/jinshengtao/article/details/26278725)
- [Single Gaussian Background Model 3](https://blog.csdn.net/u014568921/article/details/46685003)

## librealsense install sop

### linux system prerequisites
```
sudo apt-get install -y build-essential 
sudo apt-get install -y cmake
sudo apt install cmake-curses-gui
sudo apt-get update
sudo apt-get upgrade 
sudo apt-get dist-upgrade
sudo add-apt-repository ppa:notepadqq-team/notepadqq
sudo apt-get update
sudo apt-get install notepadqq
sudo apt-get install openssh-server
sudo apt-get install gcin
```

### Update linux kernel version 4.16

- [How to Install Kernel 4.16 in Ubuntu / Linux Mint](http://ubuntuhandbook.org/index.php/2018/04/install-kernel-4-16-ubuntu-linux-mint/)

- 1. download Kernel 4.16(.deb)
- 2. command
```
cd /tmp/
wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.16/linux-headers-4.16.0-041600_4.16.0-041600.201804012230_all.deb
wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.16/linux-headers-4.16.0-041600-generic_4.16.0-041600.201804012230_amd64.deb
wget -c http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.16/linux-image-4.16.0-041600-generic_4.16.0-041600.201804012230_amd64.deb
sudo dpkg -i *.deb
```

### realsense sdk

- [Linux Distribution](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md#linux-distribution)

```
sudo apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u
sudo rm -f /etc/apt/sources.list.d/realsense-public.list
sudo apt-get update
sudo apt-get install librealsense2-dkms
sudo apt-get install librealsense2-utils
sudo apt-get install librealsense2-dev
sudo apt-get install librealsense2-dbg
modinfo uvcvideo | grep "version:"
-> should include realsense string
```

### librealsense

- [Linux Ubuntu Installation](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation.md)
- 1. command - prerequisites 1
```
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
sudo apt-get install --install-recommends linux-generic-lts-xenial xserver-xorg-core-lts-xenial xserver-xorg-lts-xenial xserver-xorg-video-all-lts-xenial xserver-xorg-input-all-lts-xenial libwayland-egl1-mesa-lts-xenial
sudo update-grub && sudo reboot
uname -r
->verify that a supported kernel version (4.[4,8,10,13,15,16]]) 
```
- 2. download github repository
- [Intel® RealSense™ SDK 2.0 (build 2.16.5)](https://github.com/IntelRealSense/librealsense/releases/tag/v2.16.5)

- 3. command - prerequisites 2
```
sudo apt-get install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
sudo apt-get install libglfw3-dev
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger
./scripts/patch-ubuntu-kernel-4.16.sh
cd ./scripts/
./patch-arch.sh
-> somewhere fail like
-> HTTP request sent, awaiting response... 404 Not Found
-> 2018-11-23 18:42:12 ERROR 404: Not Found.
-> [[[[[[but it's fine]]]]]]
sudo dmesg | tail -n 50
-> The log should indicate that a new uvcvideo driver has been registered.
echo 'hid_sensor_custom' | sudo tee -a /etc/modules
```
- 4. building librealsense2 SDK
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-5 g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
sudo update-alternatives --set gcc "/usr/bin/gcc-5"
gcc -v
-> you should see gcc 5.0.0 or upper
mkdir build && cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=false
sudo make uninstall && make clean && make -j8 && sudo make install
```
- 5. try realsense-viewer

```
realsense-viewer
```

### Device Firmware Update (DFU) for Linux

- 1. download Latest Firmware for Intel® RealSense™ D400 Product Family
- [Latest Firmware for Intel® RealSense™ D400 Product Family](https://downloadcenter.intel.com/download/28237/Latest-Firmware-for-Intel-RealSense-D400-Product-Family?v=t)
- 2. command
```
echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/aptrepo xenial main' | sudo tee /etc/apt/sources.list.d/realsensepublic.list
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 6F3EFCDE
sudo apt-get update
sudo apt-get install intel-realsense-dfu*
lsusb
-> get bus number & device number form Intel Corp., like bus=002, device=003
-> Bus 002 Device 003: ID 8086:0b07 Intel Corp. 
-> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
-> Bus 001 Device 003: ID 17ef:6099 Lenovo 
-> Bus 001 Device 002: ID 17ef:608d Lenovo 
-> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
intel-realsense-dfu -b 002 -d 003 -f -i /home/ubuntu/Downloads/Signed_Image_UVC_5_10_6_0.bin

```


## TODO

- 1. command "realsense-viewer" then show

```
23/11 19:25:45,239 WARNING [140063559751424] (sensor.cpp:338) Unregistered Media formats : [ UYVY ]; Supported: [ ]
23/11 19:25:45,246 WARNING [140063559751424] (backend-v4l2.cpp:1248) Pixel format 36315752-1a66-a242-9065-d01814a likely requires patch for fourcc code RW16!
23/11 19:25:45,246 WARNING [140063559751424] (sensor.cpp:338) Unregistered Media formats : [ RW16 ]; Supported: [ ]
23/11 19:25:45,363 ERROR [140063859575360] (tm-context.cpp:34) Failed to create TrackingManager
```


## opencv3.1 install

- [opencv install](https://docs.opencv.org/3.1.0/d7/d9f/tutorial_linux_install.html)

```
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
git clone https://github.com/Itseez/opencv.git

cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j7
sudo make install
```

## issue

### librealsense

- 0)Command
- ./scripts/patch-realsense-ubuntu-lts.sh
- 1)Problem
```
Applying the patched module ... modprobe: ERROR: could not insert 'videodev': Required key not available
Failed to insert the patched module. Operation is aborted, the original module is restored
Verify that the current kernel version is aligned to the patched module version
modprobe: ERROR: could not insert 'videodev': Required key not available
```
- 2)Use
- [installation qestion ------ could not insert 'videodev'](https://github.com/IntelRealSense/librealsense/issues/1225)
```
uname -r
sudo dmesg | tail -n 50

sudo apt-get install realsense-uvcvideo
```
- 3)Problem
```
Replacing videodev :
Applying the patched module ... modprobe: ERROR: could not insert 'videodev': Required key not available
Failed to insert the patched module. Operation is aborted, the original module is restored
Verify that the current kernel version is aligned to the patched module version
modprobe: ERROR: could not insert 'videodev': Required key not available
```
- 
- 0)Command
- ./build/examples/capture/rs-capture
- 1)Problem
```
22/11 17:59:46,185 ERROR [139842681517888] (backend-v4l2.cpp:518) 
Cannot access /sys/class/video4linux
```
- 2)Use
- [Cannot access /sys/class/video4linux](https://github.com/IntelRealSense/librealsense/issues/2747)











