#!/bin/bash

paths='hardware/interfaces/keymaster hardware/libhardware system/core/trusty/libtrusty system/keymaster system/security system/hardware/interfaces vendor/sprd/proprietories-source/sprdtrusty vendor/sprd/proprietories-source/arm-trusted-firmware-1.3 kernel/drivers/trusty/'

ctag_path=
for path in $paths
do
if [ ! -d $path ];then
ctag_path=`echo "$ctag_path $path"`
fi
done
if [ ! "x$ctag_path" == "x" ];then
#echo $ctag_path
ctags -R $ctag_path --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q
fi
