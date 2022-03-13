#!/bin/bash

cd ~/dev/pingtest_rrd/ || exit 1

for what in drucker ipad iphone ps4 win10-pc-1 win10-pc-2 linux-kiste; do
  /usr/bin/rrdtool create ping_personal_devices_"${what}".rrd \
    --step 60 \
    DS:pl:GAUGE:600:0:100 \
    DS:rtt:GAUGE:600:0:10000000 \
    RRA:AVERAGE:0.5:1:800 \
    RRA:AVERAGE:0.5:6:800 \
    RRA:AVERAGE:0.5:24:800 \
    RRA:AVERAGE:0.5:288:800 \
    RRA:MAX:0.5:1:800 \
    RRA:MAX:0.5:6:800 \
    RRA:MAX:0.5:24:800 \
    RRA:MAX:0.5:288:800
done

