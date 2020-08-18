#!/bin/sh

cd /cephfs/home

for i in * ; do
        if [ -d $i ] ; then
                size=`getfattr -n ceph.dir.rbytes  --only-values $i`
                gsize=$(($size / 1024 / 1024 /1024))
                printf "$i \t\t%.0fG\n" $gsize
        fi
done
