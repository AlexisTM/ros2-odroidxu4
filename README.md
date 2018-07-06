# ros2-odroidxu4
ROS2 XU4 crosscompile 

## Install cross tool package

> http://odroid.com/dokuwiki/doku.php?id=en:xu3_building_kernel

```bash
$ sudo mkdir /opt/toolchains
$ sudo cp arm-eabi-4.6.tar.gz /opt/toolchains
$ cd /opt/toolchains
$ sudo tar zxvf arm-eabi-4.6.tar.gz
```

## .bashrc environnement

Add the following to .bashrc or equivalent

```bash
cross_odroidxu4() {
  export ARCH=arm
  export PATH=${PATH}:/opt/toolchains/arm-eabi-4.6/bin
  export CROSS_COMPILE=arm-eabi-
}
```


## Building

> https://github.com/ros2-for-arm/ros2/wiki/ROS2-on-arm-architecture

```bash
mkdir -p ros2_ws/src
cd ros2_ws
wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
wget https://raw.githubusercontent.com/ros2-for-arm/ros2/master/ros2-for-arm.repos
wget https://raw.githubusercontent.com/AlexisTM/ros2-odroidxu4/master/README.md
vcs-import src < ros2.repos 
vcs-import src < ros2-for-arm.repos
```

## Build

```bash
src/ament/ament_tools/scripts/ament.py build --force-cmake-configure --cmake-args -DCMAKE_TOOLCHAIN_FILE=`pwd`/armv7l_toolchainfile.cmake -DTHIRDPARTY=ON
```

