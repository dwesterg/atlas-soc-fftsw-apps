#!/bin/sh

cd $(dirname ${0})

[ -d 'Ne10' ] && {
	echo ""
	echo "ERROR: directory 'Ne10' already exists, please remove before proceeding."
	echo ""
	exit 1
}

type -t arm-angstrom-linux-gnueabi-gcc > /dev/null 2>&1 || {
	echo ""
	echo "ERROR: cross compiler tools are not visible in the environment."
	echo ""
	exit 1
}

git clone http://github.com/projectNe10/Ne10

cd Ne10
rm -rf *
git checkout -f master

sed \
	-i "s/arm-linux-gnueabihf-/arm-angstrom-linux-gnueabi-/g" \
	GNUlinux_config.cmake

mkdir build && cd build

cmake \
	-DCMAKE_TOOLCHAIN_FILE=../GNUlinux_config.cmake \
	-DCMAKE_CXX_FLAGS="-mfloat-abi=hard" \
	-DCMAKE_C_FLAGS="-mfloat-abi=hard" \
	..

make

