#!/vendor/bin/sh
#
# Running at boot begining
# Prepare for booting

/vendor/bin/echo %%%%%%%%/data/vendor/wifi/wpa//wifi have not p2p_supplicant.conf
if [ ! -s /data/vendor/wifi/wpa/p2p_supplicant.conf ] ; then
    /vendor/bin/echo %%%%%%%%/data/vendor/wifi/wpa/wifi have not p2p_supplicant.conf
    /vendor/bin/cp -a /vendor/etc/wifi/p2p_supplicant.conf /data/vendor/wifi/wpa/
    /vendor/bin/chmod 777 /data/vendor/wifi/wpa/p2p_supplicant.conf
fi
