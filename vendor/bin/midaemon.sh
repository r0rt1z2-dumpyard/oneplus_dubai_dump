#!/vendor/bin/sh

export LD_LIBRARY_PATH=/mnt/vendor/tvservice/glibc:/vendor/tvconfig/config:/vendor/lib

/mnt/vendor/tvservice/bin/midaemon &

wait

