

LD_LIBRARY_PATH=/root/lab/sva/cheri/beri/beri-u14/cherilibs/trunk/peripherals:/root/lab/sva/cheri/beri/beri-u14/cheri/trunk \
     CHERI_KERNEL=arcina-cheribsd-beri-sim-mdroot-singleuser-kernel \
     CHERI_CONFIG=simconfig \
     CHERI_CONSOLE_SOCKET=/tmp/beri/console-socket \
     PISM_MODULES_PATH=/root/lab/sva/cheri/beri/beri-u14/cherilibs/trunk/peripherals \
     BERI_DEBUG_SOCKET_0=/tmp/beri/debug-socket-0 \
     BERI_DEBUG_SOCKET_1=/tmp/beri/debug-socket-1 \
    /root/lab/sva/cheri/beri/beri-u14/cheri/trunk/sim | grep -v 'capTags: 0'


