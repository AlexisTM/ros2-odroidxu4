# ros2-odroidxu4
ROS2 XU4 crosscompile 

*Current issues:*

* `-rdynamic` not recognized by the toolchain
* How to use the sysroot for precompiled libraries?

## Install cross tool package

> http://odroid.com/dokuwiki/doku.php?id=en:xu3_building_kernel

```bash
$ sudo mkdir /opt/toolchains
$ sudo cp arm-eabi-4.6.tar.gz /opt/toolchains
$ cd /opt/toolchains
$ sudo tar zxvf arm-eabi-4.6.tar.gz
```

Add the following to .bashrc or equivalent

```bash
cross_odroidxu4() {
  export ARCH=arm
  export PATH=${PATH}:/opt/toolchains/arm-eabi-4.6/bin
  export CROSS_COMPILE=arm-eabi-
}
```

## Setup ROS2 build environnement

> https://github.com/ros2/ros2/wiki/Linux-Development-Setup

```bash
sudo apt update
sudo apt install -y git wget
sudo apt install -y build-essential cppcheck cmake libopencv-dev python-empy python3-catkin-pkg-modules python3-dev python3-empy python3-nose python3-pip python3-pyparsing python3-setuptools python3-vcstool python3-yaml libtinyxml-dev libeigen3-dev libassimp-dev libpoco-dev
# [Ubuntu 16.04] you will need a newer setuptools version than the one available from Debian
sudo -H python3 -m pip install -U setuptools
sudo apt install -y python3-colcon-common-extensions
# dependencies for testing
sudo apt install -y clang-format pydocstyle pyflakes python3-coverage python3-mock python3-pep8 uncrustify
# Install argcomplete for command-line tab completion from the ROS2 tools.
# Install from pip rather than from apt the version in Ubuntu is too old:
sudo -H python3 -m pip install argcomplete
# additional testing dependencies from pip (because not available on Ubuntu)
sudo -H python3 -m pip install flake8 flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-docstrings flake8-import-order flake8-quotes
# [Ubuntu 18.04] Install pytest and pytest plugins
sudo apt install -y python3-pytest python3-pytest-cov python3-pytest-runner
# [Ubuntu 16.04] Install pytest and pytest plugins from pip
sudo -H python3 -m pip install pytest pytest-cov pytest-runner
# additional pytest plugins unavailable from Debian
sudo -H python3 -m pip install pytest-repeat pytest-rerunfailures
# dependencies for FastRTPS
sudo apt install -y libasio-dev libtinyxml2-dev
# [Ubuntu 16.04] install dependencies for building poco
sudo apt install -y libexpat1-dev libpcre3-dev libsqlite3-dev zlib1g-dev
# dependencies for RViz
sudo apt install -y libcurl4-openssl-dev libfreetype6-dev libgles2-mesa-dev libglu1-mesa-dev libqt5core5a libqt5gui5 libqt5opengl5 libqt5widgets5 libxaw7-dev libxrandr-dev qtbase5-dev
```


## Building

SYSROOT:

```bash
sudo apt install sshfs
mkdir -p ~/SYSROOT
sshfs -o follow_symlinks -o transform_symlinks root@172.22.72.100:/ ~/SYSROOT/
```

> https://github.com/ros2-for-arm/ros2/wiki/ROS2-on-arm-architecture

```bash
mkdir -p ros2_ws/src
cd ros2_ws
wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
wget https://raw.githubusercontent.com/ros2-for-arm/ros2/master/ros2-for-arm.repos
wget https://raw.githubusercontent.com/AlexisTM/ros2-odroidxu4/master/armv7l_toolchainfile.cmake
vcs-import src < ros2.repos 
vcs-import src < ros2-for-arm.repos

colcon build --symlink-install --merge-install --cmake-args -DCMAKE_TOOLCHAIN_FILE=`pwd`/armv7l_toolchainfile.cmake -DTHIRDPARTY=ON
```

## Build

```bash
src/ament/ament_tools/scripts/ament.py build --force-cmake-configure --cmake-args -DCMAKE_TOOLCHAIN_FILE=`pwd`/armv7l_toolchainfile.cmake -DTHIRDPARTY=ON
```

