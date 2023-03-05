#!/sbin/sh

#mknod /dev/zram0 b 253 0
#mknod /dev/block/zram0 b 253 0
#mknod /dev/zram1 b 253 1
#mknod /dev/block/zram1 b 253 1

# wait for ueventd to create /dev/block/zram0
wait /dev/block/zram0
/vendor/bin/restorecon /dev/block/zram0

# wait for ueventd to create /dev/block/zram1
wait /dev/block/zram1
/vendor/bin/restorecon /dev/block/zram1

# By default, the Linux kernel swaps in 8 pages of memory at a time. When
# using ZRAM, the incremental cost of reading 1 page at a time is negligible
# and may help in case the device is under extreme memory pressure.
/vendor/bin/echo 0 > /proc/sys/vm/page-cluster

# ZRAM in Linux free memory
ZRAM_SIZE=600 # unit: MB , 0 = disable
if [ ${ZRAM_SIZE} -ne 0 ] ; then
    /vendor/bin/echo $((${ZRAM_SIZE}*1024*1024)) > /sys/block/zram0/disksize
    /vendor/bin/mkswap /dev/block/zram0
    # Set higher priority than swam in FBM
    /vendor/bin/swapon /dev/block/zram0 -p 0
fi
/vendor/bin/echo 1 > /mnt/vendor/tmp/zram_start
