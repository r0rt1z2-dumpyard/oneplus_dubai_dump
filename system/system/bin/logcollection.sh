#!/bin/sh

fn_init()
{
    echo -e "\n fn_init"
    /system/bin/rm -rf /data/log/3
    /system/bin/mv /data/log/2 /data/log/3
    /system/bin/mv /data/log/1 /data/log/2
    /system/bin/mkdir /data/log/1
    /system/bin/chmod 0777 /data/log/1
}

fn_collectlog()
{
    echo -e "\n fn_collectlog"
    if [ -d "/data/log/1" ];then
        /system/bin/logcat -v time -b all -r 5120 -n 10 -f /data/log/1/log.txt
    fi
}

fn_init
fn_collectlog
