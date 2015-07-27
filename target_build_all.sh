#!/bin/sh

APP_LIST="
create_real_short_sine32
create_real_short_square32
create_real_short_triangle32
real_short_to_ne10cpx_long
real_short_to_ne10cpx_short
ne10cpx_short_to_text
ne10cpx_long_to_text
c16_256
c32_256
fft_256
fftdma_256
neon16_256
neon32_256
c16_4096
c32_4096
fft_4096
fftdma_4096
neon16_4096
neon32_4096
c16_256x32
c32_256x32
fft_256x32
fftdma_256x32
neon16_256x32
neon32_256x32
c16_256x32x128
c32_256x32x128
fft_256x32x128
fftdma_256x32x128
neon16_256x32x128
neon32_256x32x128
stream_fpga_256x32x128
stream_fpga_256x16x1
stream_fpga_256x1x1
stream_neon32_256x32x128
stream_neon32_256x16x1
stream_neon32_256x1x1
stream_raw_256x32x128
stream_raw_256x16x1
stream_raw_256x1x1
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

