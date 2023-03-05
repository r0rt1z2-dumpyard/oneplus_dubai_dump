#!/vendor/bin/sh
while [ ! -f /mnt/vendor/tmp/mknod_util_end ] ;
do
   /vendor/bin/sleep 0.1
done

/vendor/bin/MtkRmInitServer &

/vendor/bin/touch /mnt/vendor/tmp/mtk_rm_end
/vendor/bin/sync

wait
echo "mtk_rm end"
