#!/vendor/bin/sh

source /vendor/etc/boot.conf

while [ ! -f /mnt/vendor/tmp/mtk_rm_end ] ;
do
      /vendor/bin/sleep 0.1
done

# default umask in Linux world
umask 000

#wait /dev/fusion0 create for fix linux world access fail.
while [ ! -c /dev/fusion0 ] ;
do
      /vendor/bin/sleep 0.1
done

# Launch TV F/W
/vendor/bin/echo "--- Launch TV F/W --- "
/vendor/bin/sh /vendor/etc/rc.local

while true
do
if [ -f /mnt/vendor/tmp/dtv_svc_is_ready ];then
    break
fi
/vendor/bin/sleep 0.1
done

/vendor/bin/echo "==> dtv_svc end" > /proc/boottime

# 20210903 zhoubo add for opt irq balance
/vendor/bin/echo 2 > /proc/irq/50/smp_affinity
/vendor/bin/echo 2 > /proc/irq/52/smp_affinity
/vendor/bin/echo 4 > /proc/irq/64/smp_affinity
/vendor/bin/echo 4 > /proc/irq/70/smp_affinity
/vendor/bin/echo 8 > /proc/irq/66/smp_affinity

# Factory mode via ttyMT3
stty -F /dev/ttyS0 115200

# for CTS user build debug, in uboot: addboot logcat_print=1
grep logcat_print=1 /proc/cmdline > /dev/null

if [ $? == 0 ]; then
    /vendor/bin/sleep 20
    logcat -v time &
fi

# Keep service alive
while [ 1 ] ;
do
    /vendor/bin/sleep 100d
done
