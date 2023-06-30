#!/bin/bash
NDKROOT_PATH=/home/ubuntu/share/NDK/android-ndk-r23c
CUR_PATH=$(pwd)

export TOOLCHAIN=$NDKROOT_PATH/toolchains/llvm/prebuilt/linux-x86_64


function build {
	./configure --host=${TARGET} \
		--enable-pic \
		--enable-static  \
		--enable-shared \
		--extra-cflags="-fPIC" \
		--prefix=${CUR_PATH}/Android/${CPU} \
		--enable-pic \
		--enable-strip 

	make clean
	make -j8
	make install
	echo "
		build ${CPU} finished... 
	"
}


echo "
*************************************
	build amrv7a
*************************************
"
export CPU=armv7a
export TARGET=armv7a-linux-androideabi
export API=31
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
build


echo "
*************************************
	build amrv7a
*************************************
"
export CPU=armv8a
export TARGET=aarch64-linux-android
export API=31
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
build

