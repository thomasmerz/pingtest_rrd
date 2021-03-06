#!/bin/bash

cd ~/dev/pingtest_rrd/ || exit 1

# Note: The following RRD files are created with a step size of 60
# seconds, hence they are suitable with Interval value of 5 in rrd.cfg.
# If you plan on running with Interval 1, you should recreate these files
# with a step size of 60 and RRA as follows
#    DS:some_data_source:GAUGE:120:0:200
#    RRA:AVERAGE:0.5:1:600
#    RRA:AVERAGE:0.5:5:600
#    RRA:AVERAGE:0.5:30:700
#    RRA:AVERAGE:0.5:120:775
#    RRA:AVERAGE:0.5:1440:797
#    RRA:MAX:0.5:1:600
#    RRA:MAX:0.5:5:600
#    RRA:MAX:0.5:30:700
#    RRA:MAX:0.5:120:775
#    RRA:MAX:0.5:1440:797

what_int='192.168.0.1 192.168.0.2 192.168.0.3'
what_ext='heise.de spiegel.de startpage.com'
for what in $what_int $what_ext; do
  /usr/bin/rrdtool create ping_"${what}".rrd \
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

