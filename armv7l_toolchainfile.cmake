# Copyright (c) 2018, ARM Limited.
# SPDX-License-Identifier: Apache-2.0

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR armeabi-v7a)
# specify the cross compiler
set(CMAKE_C_COMPILER $ENV{CROSS_COMPILE}gcc)
set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER $ENV{CROSS_COMPILE}g++)
set(CMAKE_CXX_COMPILER_WORKS 1)
# where is the target environment


SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

set(CMAKE_LIBRARY_PATH
  $ENV{HOME}/SYSROOT/usr/lib
  $ENV{HOME}/SYSROOT/usr/lib/arm-linux-gnueabihf)

set(LD_LIBRARY_PATH ${LD_LIBRARY_PATH}
  $ENV{HOME}/SYSROOT/usr/lib
  $ENV{HOME}/SYSROOT/usr/lib/arm-linux-gnueabihf)


set(CMAKE_FIND_ROOT_PATH $ENV{HOME}/SYSROOT)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# This assumes that pthread will be available on the target system
# (this emulates that the return of the TRY_RUN is a return code "0"
set(THREADS_PTHREAD_ARG "0"
  CACHE STRING "Result from TRY_RUN" FORCE)
