echo "MM log"

logcat -G 64M
setprop ms.vdec.log 2
setprop ms.omx.log 1
setprop ms.vsync_bridge.log 1
setprop ms.mstplayer.omx 1
setprop ms.avp.debug.demuxer 1
setprop mstar.sideband.log 1
setprop mstar.dip.log 1
logcat -c
logcat -v threadtime -f /data/dump.txt
