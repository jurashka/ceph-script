#!/bin/bash
#GPLv3

date=`date +%Y-%m-%H:%m`

OSD=`ceph health | grep 'slow ops, oldest one blocked for' | awk -F'[][]' '{print $2}' | sed s/osd\.//g | sed s/\,/\ /g`
#echo $OSD

2log=""

for osd in $OSD
do
        if [ ! $2log ] ; then
                $2log="1"
                echo "$date" >> /root/ceph_hung_osd_restart.log
        fi
        host=$(ceph osd find $osd | awk -F\" '$2 ~ /host/ {print $4;exit}')
        echo "ssh $host systemctl restart ceph-osd@${osd}.service" >> /root/ceph_hung_osd_restart.log
        ssh $host systemctl restart ceph-osd@${osd}.service
done
