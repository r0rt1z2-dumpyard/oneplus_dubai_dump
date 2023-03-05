#!/vendor/bin/sh

if [ -e /mnt/vendor/tvservice/bin/cpu_audio ] ; then
    echo ""
    echo "CPU_AUDIO is running!"
    echo ""
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/vendor/linux_rootfs/lib
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/vendor/tvservice/glibc
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/vendor/linux_rootfs/lib
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/vendor/linux_rootfs/basic
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/vendor/linux_rootfs/basic/lib
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/vendor/lib
    /mnt/vendor/linux_rootfs/lib/ld-linux.so.3  /mnt/vendor/tvservice/bin/cpu_audio &
    wait
    echo "cpu_audio end"
fi
