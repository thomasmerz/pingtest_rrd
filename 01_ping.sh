#!/bin/bash

cd ~/dev/pingtest_rrd/ || exit 1

PING=/bin/ping
COUNT=4
DEADLINE=10

ping_host() {
    output="$($PING -q -n -c $COUNT -w $DEADLINE "$1" 2>&1)"
    local output
    # notice $output is quoted to preserve newlines
    temp=$(echo "$output"| awk '
        BEGIN           {pl=100; rtt=0.1}
        /packets transmitted/   {
            match($0, /([0-9]+)% packet loss/, matchstr)
            pl=matchstr[1]
        }
        /^rtt/          {
            # looking for something like 0.562/0.566/0.571/0.024
            match($4, /(.*)\/(.*)\/(.*)\/(.*)/, a)
            rtt=a[2]
        }
        /unknown host/  {
            # no output at all means network is probably down
            pl=100
            rtt=0.1
        }
        END         {print pl ":" rtt}
        ')
    RETURN_VALUE=$temp
}

# ping a host on the local lan
for internal_network in 192.168.0.1 192.168.0.2 192.168.0.3; do
  ping_host $internal_network
  /usr/bin/rrdtool update \
      ping_$internal_network.rrd \
      --template \
      pl:rtt \
      N:"$RETURN_VALUE"
  # https://forum.syncthing.net/t/why-are-rrd-files-transferred-by-time-and-not-immediately/16391
  touch ping_$internal_network.rrd
done

# ping a host on the external network
for external_network in heise.de spiegel.de startpage.com; do
  ping_host $external_network
  /usr/bin/rrdtool update \
      ping_$external_network.rrd \
      --template \
      pl:rtt \
      N:"$RETURN_VALUE"
  # https://forum.syncthing.net/t/why-are-rrd-files-transferred-by-time-and-not-immediately/16391
  touch ping_$external_network.rrd
done

