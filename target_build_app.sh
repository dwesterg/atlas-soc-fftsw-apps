#!/bin/sh

type -t gcc > /dev/null 2>&1 || {
	echo ""
	echo "ERROR: cross compiler tools are not visible in the environment."
	echo ""
	exit 1
}

[ -d './Ne10-master/inc' ] || {
	echo ""
	echo "ERROR: cannot locate include directory './Ne10-master/inc'."
	echo ""
	exit 1
}

[ -f './Ne10-master/build/modules/libNE10.a' ] || {
	echo ""
	echo "ERROR: cannot locate library archive './Ne10-master/build/modules/libNE10.a'."
	echo ""
	exit 1
}


[ "$#" -eq "1" ] || {
	echo ""
	echo "USAGE: ${0} <application name>"
	echo ""
	exit 1
}

[ -e "${1}" ] && {
	echo ""
	echo "${1} already exists"
	echo "please remove it and try again"
	echo "rm ${1}"
	echo ""
	exit 1
}

[ -e "${1}.c" ] || {
	echo ""
	echo "${1}.c does not exists"
	echo "cannot compile it"
	echo ""
	exit 1
}

gcc \
	-march=armv7-a \
	-mfloat-abi=hard \
	-mfpu=vfp3 \
	-mthumb-interwork \
	-mthumb \
	-O2 \
	-g \
	-feliminate-unused-debug-types  \
	-std=gnu99 \
	-W \
	-Wall \
	-Werror \
	-Wc++-compat \
	-Wwrite-strings \
	-Wstrict-prototypes \
	-pedantic \
	-I./Ne10-master/inc \
	-o "${1}.o" \
	-c \
	"${1}.c"

[ "${1}.c" -nt "${1}.o" ] && {
	echo ""
	echo "${1}.c is newer than ${1}.o"
	echo "cannot link it"
	echo ""
	exit 1
}

g++ \
	-march=armv7-a \
	-mfloat-abi=hard \
	-mfpu=vfp3 \
	-mthumb-interwork \
	-mthumb \
	-O2 \
	-g \
	"${1}.o" \
	-o "${1}" \
	-L. \
	-loverhead \
	-rdynamic ./Ne10-master/build/modules/libNE10.a \
	-lm

