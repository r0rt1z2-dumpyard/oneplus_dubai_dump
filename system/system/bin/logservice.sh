#!/bin/sh
#logtype 0-ram 1-persist
LogType=`getprop persist.vendor.opbridge.logtype`
LogFileCnt=`getprop persist.vendor.opbridge.filecnt`
LogFileSize=5120
LogPath=""
echo "LogType=$LogType"
case $LogType in
  0)
    echo "log in ram..."
	LogPath=/mnt/expand/feedback
	;;
  1)
    echo "log persist..."
	LogPath=/mnt/sdcard/log/feedback
	;;
  *)
    echo "default log in ram..."
	LogType=0
	LogPath=/mnt/expand/feedback
    ;;
esac

if [[ $LogFileCnt -eq "" ]];
then
LogFileCnt=4
fi

echo "LogPath=$LogPath"
if [ ! -d $LogPath ];
then
mkdir -p $LogPath
if [ $LogType == "0" ]
then
chcon -R u:object_r:sdcardfs:s0 $LogPath
fi
fi

targetFile="$LogPath/feedbacklog"

cmd="/system/bin/logcat -b all -r $LogFileSize -n $LogFileCnt -f $targetFile"

#run logcat
echo "enter:$cmd ...\n"
$cmd