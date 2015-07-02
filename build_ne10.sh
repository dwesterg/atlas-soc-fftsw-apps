#!/bin/sh

cd $(dirname ${0})

[ -d 'Ne10-master' ] && {
	echo ""
	echo "ERROR: directory 'Ne10-master' already exists, please remove before proceeding."
	echo ""
	exit 1
}

type -t ${CC:?} > /dev/null 2>&1 || {
	echo ""
	echo "ERROR: cross compiler tools are not visible in the environment."
	echo ""
	exit 1
}

################################################################################
# previously used this method to clone and checkout master
################################################################################
#
# git clone http://github.com/projectNe10/Ne10
# cd Ne10
# rm -rf *
# git checkout -f master

################################################################################
# now using the Ne10-master.zip archive
################################################################################

[ -f 'Ne10-master.zip' ] || {
	echo ""
	echo "ERROR: file 'Ne10-master.zip' does not exist."
	echo ""
	exit 1
}

unzip Ne10-master.zip

[ -d 'Ne10-master' ] || {
	echo ""
	echo "ERROR: directory 'Ne10-master' does not exist after archive extraction."
	echo ""
	exit 1
}

cd Ne10-master

sed \
	-i "s/arm-linux-gnueabihf-/${CC%gcc}/g" \
	GNUlinux_config.cmake

mkdir build && cd build

cmake \
	-DCMAKE_TOOLCHAIN_FILE=../GNUlinux_config.cmake \
	-DCMAKE_CXX_FLAGS="-mfloat-abi=hard" \
	-DCMAKE_C_FLAGS="-mfloat-abi=hard" \
	..

make

