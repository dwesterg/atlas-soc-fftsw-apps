#!/bin/sh

APP_LIST="
create_real_short_sine32
create_real_short_square32
create_real_short_triangle32
real_short_to_ne10cpx_long
real_short_to_ne10cpx_short
ne10cpx_long_to_text
fftdma_256
neon32_256
"

LIB_LIST="
overhead
"

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

for NEXT in ${LIB_LIST}
do
	./target_build_lib.sh "${NEXT}"
done

for NEXT in ${APP_LIST}
do
	./target_build_app.sh "${NEXT}"
done

