#!/vendor/bin/sh
c=$(cat /proc/cmdline)
c="${c##*bootvideo.enable=}"
c="${c%% *}"

if [ $c == 1 ]; then
    echo "Run bootvideo!"
    /vendor/bin/demo_bootvideo /data/vendor/video.ts
else
    touch /mnt/vendor/tmp/chk_bootvideo_done
fi
