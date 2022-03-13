#!/bin/bash

cd ~/dev/pingtest_rrd/ || exit 1

for personal_devices in drucker ipad iphone ps4 win10-pc-1 win10-pc-2 linux-kiste; do
  cp -af index_template.html index_personal_devices_$personal_devices.html
  sed -i "s/192.168.0.1/$personal_devices/g" index_personal_devices_$personal_devices.html
  sed -i "s/src=ping_/src=ping_personal_devices_/g" index_personal_devices_$personal_devices.html
done

