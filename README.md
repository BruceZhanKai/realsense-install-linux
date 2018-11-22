# realsense-install-linux

## reference

### librealsense
- [github install](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation.md)
- [realsense sdk install](https://software.intel.com/sites/products/realsense/sdk/getting_started.html#Installing_the_SDK)
- [Error running RealSense D435 on Ubuntu 16.04(4.4.0-131-generic)](https://stackoverflow.com/questions/51940928/error-running-realsense-d435-on-ubuntu-16-044-4-0-131-generic)
- [RuntimeError: No device connected](https://github.com/IntelRealSense/librealsense/issues/962)
- [Realsense D435 install](https://blog.csdn.net/u012177641/article/details/80888578)
- [Realsense SR300 install](https://blog.csdn.net/z17816876284/article/details/79159518)
- [github wrapper opencv](https://github.com/IntelRealSense/librealsense/tree/master/wrappers/opencv)
- [Point Cloud Library](http://docs.pointclouds.org/trunk/)
- [Single Gaussian Background Model 1](http://blog.51cto.com/underthehood/484191)
- [Single Gaussian Background Model 2](https://blog.csdn.net/jinshengtao/article/details/26278725)
- [Single Gaussian Background Model 3](https://blog.csdn.net/u014568921/article/details/46685003)

## librealsense install sop

### basic system
```
sudo apt-get install -y build-essential 
sudo apt-get install -y cmake
sudo apt install cmake-curses-
sudo apt-get update
sudo apt-get upgrade 
sudo apt-get dist-upgrade
sudo add-apt-repository ppa:notepadqq-team/notepadqq
udo apt-get update
sudo apt-get install notepadqq
sudo apt-get install openssh-server
sudo apt-get install gcin
```
### librealsense
```
sudo apt-get install git
git clone https://github.com/IntelRealSense/librealsense
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
sudo apt-get install libudev-dev pkg-config libgtk-3-dev
sudo apt-get install libusb-1.0-0-dev pkg-config
cd librealsense
mkdir build && cd build
cmake ../ -DBUILD_EXAMPLES=true
```
```
cd ~/librealsense/
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d
sudo udevadm control --reload-rules && udevadm trigger
sudo apt-get install libssl-dev
./scripts/patch-realsense-ubuntu-xenial.sh
./scripts/patch-arch.sh
./scripts/install_glfw3.sh
./scripts/install_dependencies-4.4.sh
./scripts/patch-uvcvideo-4.4.sh v4.4-wily
sudo modprobe uvcvideo
sudo udevadm control --reload-rules && udevadm trigger

./scripts/patch-realsense-ubuntu-lts.sh
./scripts/patch-ubuntu-kernel-4.16.sh
```

```
sudo dmesg | tail -n 50

sudo make uninstall && make clean && make && sudo make install
```
## realsense sdk install

```
git clone http://github.com/IntelRealSense/realsense_sdk
cd realsense_sdk
mkdir build
cd build
cmake ..
make
sudo make install
```

## opencv3.1 install
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