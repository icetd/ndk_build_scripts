#!/bin/bash

# 需要修改为自己ndk版本
export NDK_HOME=/home/ubuntu/share/NDK/android-ndk-r23c
export X264_LIB=/home/ubuntu/share/x264

function build
{
	./configure \
		--prefix=${OUT_DIR} \
		--cpu=${CPU} \
		--arch=${ARCH} \
		--nm=${NM} \
		--ar=${AR} \
		--ranlib=${RANLIB} \
		--strip=${STRIP} \
		--cross-prefix=${CROSS_PREFIX}- \
		--target-os=android \
		--extra-ldexeflags=-pie \
		--disable-static \
		--enable-shared \
		--enable-libx264 \
		--enable-gpl \
		--enable-decoder=flac,ape,mp3 \
		--disable-protocols \
		--enable-protocol=file \
		--disable-muxers \
		--disable-demuxers \
		--enable-demuxer=flac,ape,mp3 \
		--enable-cross-compile \
		--enable-small \
		--enable-jni \
		--pkg-config="pkg-config --static"
#		--extra-cflags="${EXTRA_CFLAGS}" 
#		--extra-ldflags="${EXTRA_LIB}" 

	make clean
	make -j8
	make install
	echo "
		build ffmpeg for ${ARCH} finished
	"
	sleep 3
}

echo "
*********************************************
Starting build ffmpeg for armv7a
*********************************************
"
sleep 2
API=30
ARCH=arm
CPU=armv7a
PREFIX=$(pwd)/android/${ARCH}
TOOLCHAIN_PREFIX=${NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin
SYSROOT=${TOOLCHAIN_PREFIX}/sysroot
export CROSS_PREFIX=${TOOLCHAIN_PREFIX}/armv7a-linux-androideabi$API
export AR=${TOOLCHAIN_PREFIX}/llvm-ar
export NM=${TOOLCHAIN_PREFIX}/llvm-nm
export STRIP=${TOOLCHAIN_PREFIX}/llvm-strip
export RANLIB=${TOOLCHAIN_PREFIX}/llvm-ranlib
export PKG_CONFIG_PATH=/home/ubuntu/share/x264/Android/${CPU}/lib/pkgconfig
#EXTRA_CFLAGS=-I${X264_LIB}/Android/${CPU}/include
#EXTRA_LIB=-L${X264_LIB}/Android/${CPU}/lib
OUT_DIR=./Android/${CPU}
build
 

echo "
*********************************************
Starting build ffmpeg for armv8a
*********************************************
"
sleep 2
API=30
ARCH=arm64
CPU=armv8a
PREFIX=$(pwd)/android/${ARCH}
TOOLCHAIN_PREFIX=${NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin
SYSROOT=${TOOLCHAIN_PREFIX}/sysroot
export CROSS_PREFIX=${TOOLCHAIN_PREFIX}/aarch64-linux-android$API
export AR=${TOOLCHAIN_PREFIX}/llvm-ar
export NM=${TOOLCHAIN_PREFIX}/llvm-nm
export STRIP=${TOOLCHAIN_PREFIX}/llvm-strip
export RANLIB=${TOOLCHAIN_PREFIX}/llvm-ranlib
export PKG_CONFIG_PATH=/home/ubuntu/share/x264/Android/${CPU}/lib/pkgconfig
#EXTRA_CFLAGS=-I${X264_LIB}/Android/${CPU}/include
#EXTRA_LIB=-L${X264_LIB}/Android/${CPU}/lib
OUT_DIR=./Android/${CPU}
build


echo "
*********************************************
Starting build ffmpeg for x86_64
*********************************************
"
sleep 2
API=30
ARCH=x86_64
CPU=x86_64
PREFIX=$(pwd)/android/${ARCH}
TOOLCHAIN_PREFIX=${NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin
SYSROOT=${TOOLCHAIN_PREFIX}/sysroot
export CROSS_PREFIX=${TOOLCHAIN_PREFIX}/x86_64-linux-android$API
export AR=${TOOLCHAIN_PREFIX}/llvm-ar
export NM=${TOOLCHAIN_PREFIX}/llvm-nm
export STRIP=${TOOLCHAIN_PREFIX}/llvm-strip
export RANLIB=${TOOLCHAIN_PREFIX}/llvm-ranlib
export PKG_CONFIG_PATH=/home/ubuntu/share/x264/Android/${CPU}/lib/pkgconfig
#EXTRA_CFLAGS=-I${X264_LIB}/Android/${CPU}/include
#EXTRA_LIB=-L${X264_LIB}/Android/${CPU}/lib
OUT_DIR=./Android/${CPU}
build


