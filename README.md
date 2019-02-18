# realsense-install-linux

## reference

### librealsense
1. offical
- [github install](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation.md)
- [github distribution linux](https://github.com/IntelRealSense/librealsense/blob/development/doc/distribution_linux.md)
- [realsense sdk install](https://software.intel.com/sites/products/realsense/sdk/getting_started.html#Installing_the_SDK)
2. issue
- [Error running RealSense D435 on Ubuntu 16.04(4.4.0-131-generic)](https://stackoverflow.com/questions/51940928/error-running-realsense-d435-on-ubuntu-16-044-4-0-131-generic)
- [RuntimeError: No device connected](https://github.com/IntelRealSense/librealsense/issues/962)
- [Realsense D435 install](https://blog.csdn.net/u012177641/article/details/80888578)
- [Realsense SR300 install](https://blog.csdn.net/z17816876284/article/details/79159518)
- [github wrapper opencv](https://github.com/IntelRealSense/librealsense/tree/master/wrappers/opencv)
3. 	skill
- [Converting depth into 3D world coordinates intel real sense](https://software.intel.com/en-us/forums/realsense/topic/560784)
- [About world coordinates of D435 in realsense-viewer](https://github.com/IntelRealSense/librealsense/issues/2317)
- [Transforming pixel from a depth image to world coordinates](https://github.com/IntelRealSense/librealsense/issues/1904)
- [How to measure correctly](https://github.com/IntelRealSense/librealsense/issues/1788)
- [github realsense samples](https://github.com/IntelRealSense/realsense_samples)
- [Point Cloud Library](http://docs.pointclouds.org/trunk/)
- [Single Gaussian Background Model 1](http://blog.51cto.com/underthehood/484191)
- [Single Gaussian Background Model 2](https://blog.csdn.net/jinshengtao/article/details/26278725)
- [Single Gaussian Background Model 3](https://blog.csdn.net/u014568921/article/details/46685003)
- [realsense彩色图与深度图对齐](https://blog.csdn.net/wi162yyxq/article/details/69390006)
- [基于距离的图像分割](https://blog.csdn.net/SFM2020/article/details/83547210)

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

sudo apt-get install gdebi
wget http://download.xnview.com/XnViewMP-linux-x64.deb
sudo gdebi XnViewMP-linux-x64.deb
```

### Update linux kernel version 4.16

- [How to Install Kernel 4.16 in Ubuntu / Linux Mint](http://ubuntuhandbook.org/index.php/2018/04/install-kernel-4-16-ubuntu-linux-mint/)

1. download Kernel 4.16(.deb)
2. command
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
1. command - prerequisites 1
```
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
sudo apt-get install --install-recommends linux-generic-lts-xenial xserver-xorg-core-lts-xenial xserver-xorg-lts-xenial xserver-xorg-video-all-lts-xenial xserver-xorg-input-all-lts-xenial libwayland-egl1-mesa-lts-xenial
sudo update-grub && sudo reboot
uname -r
->verify that a supported kernel version (4.[4,8,10,13,15,16]]) 
```
2. download github repository
- [Intel® RealSense™ SDK 2.0 (build 2.16.5)](https://github.com/IntelRealSense/librealsense/releases/tag/v2.16.5)

3. command - prerequisites 2
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
4. building librealsense2 SDK
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-5 g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5
sudo update-alternatives --set gcc "/usr/bin/gcc-5"
gcc -v
-> you should see gcc 5.0.0 or upper
mkdir build && cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=false -DBUILD_CV_EXAMPLES=true
sudo make uninstall && make clean && make -j8 && sudo make install
```
5. try realsense-viewer

```
realsense-viewer
```

### Device Firmware Update (DFU) for Linux

1. download Latest Firmware for Intel® RealSense™ D400 Product Family
- [Latest Firmware for Intel® RealSense™ D400 Product Family](https://downloadcenter.intel.com/download/28237/Latest-Firmware-for-Intel-RealSense-D400-Product-Family?v=t)
2. command
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


### example testing

1. command "realsense-viewer" then show

```
23/11 19:25:45,239 WARNING [140063559751424] (sensor.cpp:338) Unregistered Media formats : [ UYVY ]; Supported: [ ]
23/11 19:25:45,246 WARNING [140063559751424] (backend-v4l2.cpp:1248) Pixel format 36315752-1a66-a242-9065-d01814a likely requires patch for fourcc code RW16!
23/11 19:25:45,246 WARNING [140063559751424] (sensor.cpp:338) Unregistered Media formats : [ RW16 ]; Supported: [ ]
23/11 19:25:45,363 ERROR [140063859575360] (tm-context.cpp:34) Failed to create TrackingManager
--> it's fine
```
2. command "rs-capture" then success

![rs-capture](https://github.com/BruceZhanKai/realsense-install-linux/blob/master/images/rs-capture.png "rs-capture-result")

## TODO 


### openGL install
```
sudo apt-get install build-essential libgl1-mesa-dev
sudo apt-get install freeglut3-dev
sudo apt-get install libglew-dev libsdl2-dev libsdl2-image-dev libglm-dev libfreetype6-dev
```

### opencv3.4 install (better install before librealsense)

- [opencv wrapper](https://github.com/IntelRealSense/librealsense/tree/master/wrappers/opencv#linux)

1. bild `opencv` from source using the [official guide](https://docs.opencv.org/trunk/d7/d9f/tutorial_linux_install.html)
> Please use `git checkout 3.4` to use version 3.4
2. Run `export OpenCV_DIR=~/opencv/build` (`~/opencv/build` is the folder containing `OpenCVConfig.cmake`)
3. Follow [the instructions](https://github.com/IntelRealSense/librealsense/blob/master/doc/installation.md) to build `librealsense` from source
4. Add `-DBUILD_CV_EXAMPLES=true` to your `cmake` command


```
$ sudo apt-get install build-essential
$ sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
$ sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
$ git clone https://github.com/Itseez/opencv.git
$ git checkout 3.4

$ cd ~/opencv
$ mkdir build
$ cd build
$ cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
$ make -j8
$ sudo make install
$ sudo gedit /etc/ld.so.conf.d/opencv.conf
->/usr/local/lib 
$ sudo ldconfig  
```

### reinstall opencv 3.4.4

- [Install OpenCV 3.4.4 on Ubuntu 16.04 (C++ and Python)](https://www.learnopencv.com/install-opencv-3-4-4-on-ubuntu-16-04/)

#### Step 0: Select OpenCV version to install
```
$ echo "OpenCV installation by learnOpenCV.com"
#Specify OpenCV version
$ cvVersion="3.4.4"

# Clean build directories
$ rm -rf opencv/build
$ rm -rf opencv_contrib/build
# Create directory for installation
$ mkdir installation
$ mkdir installation/OpenCV-"$cvVersion"
# Save current working directory
cwd=$(pwd)
```
#### Step 1: Update Packages
```
$ sudo apt -y update
$ sudo apt -y upgrade
```
#### Step 2: Install OS Libraries
```
$ sudo apt -y remove x264 libx264-dev
 
## Install dependencies
$ sudo apt -y install build-essential checkinstall cmake pkg-config yasm
$ sudo apt -y install git gfortran
$ sudo apt -y install libjpeg8-dev libjasper-dev libpng12-dev
 
$ sudo apt -y install libtiff5-dev
 
$ sudo apt -y install libtiff-dev
 
$ sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
$ sudo apt -y install libxine2-dev libv4l-dev
$ cd /usr/include/linux
$ sudo ln -s -f ../libv4l1-videodev.h videodev.h
$ cd $cwd
 
$ sudo apt -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
$ sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
$ sudo apt -y install libatlas-base-dev
$ sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
$ sudo apt -y install libvorbis-dev libxvidcore-dev
$ sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
$ sudo apt -y install libavresample-dev
$ sudo apt -y install x264 v4l-utils
 
# Optional dependencies
$ sudo apt -y install libprotobuf-dev protobuf-compiler
$ sudo apt -y install libgoogle-glog-dev libgflags-dev
$ sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
```

#### Step 3: Install Python Libraries

```
$ sudo apt -y install python3-dev python3-pip python3-venv
$ sudo -H pip3 install -U pip numpy
$ sudo apt -y install python3-testresources

$ cd $cwd
############ For Python 3 ############
# create virtual environment
$ python3 -m venv OpenCV-"$cvVersion"-py3
$ echo "# Virtual Environment Wrapper" >> ~/.bashrc
$ echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bashrc
$ source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate
 
# now install python libraries within this virtual environment
$ pip install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib
  
# quit virtual environment
$ deactivate
######################################
```  
If you are solely a Python user, it is easier to use  
```
$ pip install opencv-contrib-python==3.4.4.19
```
#### Step 4: Download opencv and opencv_contrib
```
$ git clone https://github.com/opencv/opencv.git
$ cd opencv
$ git checkout $cvVersion
$ cd ..
 
$ git clone https://github.com/opencv/opencv_contrib.git
$ cd opencv_contrib
$ git checkout $cvVersion
$ cd ..
```

#### Step 5: Compile and install OpenCV with contrib modules
```
$ cd opencv
$ mkdir build
$ cd build

$ sudo cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/home/ubuntu/installation/OpenCV-3.4.4 \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=/usr/local/lib/python3.5/dist-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..

$ cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.5/site-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..

$ sudo make -j8
$ sudo make install

```  
For system wide installation of OpenCV, change   
CMAKE_INSTALL_PREFIX to CMAKE_INSTALL_PREFIX=/usr/local \.  

### How to use OpenCV in C++
```  
SET(OpenCV_DIR <OpenCV_Home_Dir>/installation/OpenCV-3.4.4/share/OpenCV/)
SET(OpenCV_DIR /home/hp/OpenCV_installation/installation/OpenCV-3.4.4/share/OpenCV/)

$ mkdir build && cd build
$ cmake ..
$ cmake --build . --config Release
```  



### C++ sample code 

- [C++ sample code](https://github.com/IntelRealSense/librealsense/tree/master/examples)

0. [object-detect](http://www.voidcn.com/article/p-waviwkwq-bgc.html)
1. [ undefined reference to symbol 'pthread_create@@GLIBC_2.2.5'](https://github.com/facebook/Surround360/issues/3)
- set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pthread")
2. [Building GLFW3 Application with CMAKE - GLFW_LIBRARIES doesnt set](https://stackoverflow.com/questions/34367424/building-glfw3-application-with-cmake-glfw-libraries-doesnt-set)
3. undefined reference to symbol 'glOrtho'
- set(CMAKE_CXX_FLAGS "-lGL -lGLU -lglfw3 -lX11 -lXxf86vm -lXrandr -lpthread -lXi")
4. undefined reference to symbol 'glOrtho'
```
issue:
/usr/bin/ld: CMakeFiles/object-measure.dir/object-measure.cpp.o: undefined reference to symbol 'glOrtho'
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/libGL.so: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
CMakeFiles/object-measure.dir/build.make:113: recipe for target 'object-measure' failed
make[2]: *** [object-measure] Error 1
CMakeFiles/Makefile2:67: recipe for target 'CMakeFiles/object-measure.dir/all' failed
make[1]: *** [CMakeFiles/object-measure.dir/all] Error 2
Makefile:83: recipe for target 'all' failed
make: *** [all] Error 2
```
```
solve1:
write lines in cmakelists.txt  
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -pthread -lglut -lGLU -lGL -lGLEW -lX11 -lXxf86vm -lXrandr -lXi -lXmu")
target_link_libraries(object-measure ${DEPENDENCIES} ${OpenCV_LIBS} glfw realsense2 ${OPENGL_glu_LIBRARY})
target_link_libraries(object-measure /usr/lib/x86_64-linux-gnu/libGL.so)
```
```
solve2(fail):
I had the same problem. I think the problem is that it's not linking to libGLU, so adding the following line
-lGLU /usr/lib/x86_64-linux-gnu/libGLU.so
in ScaViSLAM/svs_build/CMakeFiles/stereo_slam.dir/link.txt
made it compile for me.

```
6. 
- [D435 RGBD](https://www.cnblogs.com/gdut-gordon/p/9151740.html)
- [D435 RGBD](https://blog.csdn.net/jacktoo123/article/details/72879370)


```

```

## issue

### librealsense

1. Command
- ./scripts/patch-realsense-ubuntu-lts.sh
2. Problem
```
Applying the patched module ... modprobe: ERROR: could not insert 'videodev': Required key not available
Failed to insert the patched module. Operation is aborted, the original module is restored
Verify that the current kernel version is aligned to the patched module version
modprobe: ERROR: could not insert 'videodev': Required key not available
```
3. Use
- [installation qestion ------ could not insert 'videodev'](https://github.com/IntelRealSense/librealsense/issues/1225)
```
uname -r
sudo dmesg | tail -n 50

sudo apt-get install realsense-uvcvideo
```
4. Problem
```
Replacing videodev :
Applying the patched module ... modprobe: ERROR: could not insert 'videodev': Required key not available
Failed to insert the patched module. Operation is aborted, the original module is restored
Verify that the current kernel version is aligned to the patched module version
modprobe: ERROR: could not insert 'videodev': Required key not available
```
- 
1. Command
- ./build/examples/capture/rs-capture
2. Problem
```
22/11 17:59:46,185 ERROR [139842681517888] (backend-v4l2.cpp:518) 
Cannot access /sys/class/video4linux
```
3. Use
- [Cannot access /sys/class/video4linux](https://github.com/IntelRealSense/librealsense/issues/2747)



## Alignment between Depth & Color

- [D435深度图片对齐到彩色图片](https://blog.csdn.net/dieju8330/article/details/85300976)

- [D435深度图片对齐到彩色图片-Eigen实现](https://blog.csdn.net/dieju8330/article/details/85346454)

- [rs-align Sample](https://github.com/IntelRealSense/librealsense/tree/master/examples/align)

## Get World Points from Image Pixels

- [rs-measure Sample](https://github.com/IntelRealSense/librealsense/tree/master/examples/measure)

```
std::vector<cv::Point> CoordinateMapping(std::vector<cv::Point> polygon_image,const rs2_intrinsics& intr , const rs2::depth_frame& frame)
{
    //TO DO: get all points of world coordinate from all points of image coordinate.
    //Use RealSense API.
    std::vector<cv::Point> polygon_world;
    float pixel[2], point[3];
    cv::Point point_world;
    for(int i = 0; i < polygon_image.size(); i++)
    {
        pixel[0]=polygon_image[i].x;
        pixel[1]=polygon_image[i].y;
        auto dist = frame.get_distance(pixel[0], pixel[1]);
        rs2_deproject_pixel_to_point(point, &intr, pixel, dist);
        point_world.x=point[0];
        point_world.y=point[1];
        polygon_world.push_back(point_world);
    }
    return polygon_world;    
}
```
