#!/bin/sh

cd ~/dev/pingtest_rrd/ || exit 1

h='drucker ipad iphone ps4 win10-pc-1 win10-pc-2 linux-kiste'
for what in $h; do

#  rrdtool graph ping_personal_devices_"${what}"_hour.png -h 500 -w 1200 -a PNG \
#  --imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
#  --start -3600 --end -60 --x-grid MINUTE:10:HOUR:1:MINUTE:30:0:%R \
#  -v "Round-Trip Time (ms)" \
#  --rigid \
#  --lower-limit 0 \
#  DEF:roundtrip=ping_personal_devices_"${what}".rrd:rtt:AVERAGE \
#  AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
#  GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
#  GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
#  GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
#  GPRINT:roundtrip:MIN:"Min\: %5.2lf\n" \

  rrdtool graph ping_personal_devices_"${what}"_day.png -h 500 -w 1200 -a PNG \
  --imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
  --lazy --start -86400 --end -60 --x-grid MINUTE:30:HOUR:1:HOUR:2:0:%H \
  -v "Round-Trip Time (ms)" \
  --rigid \
  --lower-limit 0 \
  DEF:roundtrip=ping_personal_devices_"${what}".rrd:rtt:AVERAGE \
  AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
  GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
  GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
  GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
  GPRINT:roundtrip:MIN:"Min\: %5.2lf"

  rrdtool graph ping_personal_devices_"${what}"_week.png -h 500 -w 1200 -a PNG \
  --imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
  --lazy --start -604800 --end -1800 \
  -v "Round-Trip Time (ms)" \
  --rigid \
  --lower-limit 0 \
  DEF:roundtrip=ping_personal_devices_"${what}".rrd:rtt:AVERAGE \
  AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
  GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
  GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
  GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
  GPRINT:roundtrip:MIN:"Min\: %5.2lf"

  rrdtool graph ping_personal_devices_"${what}"_month.png -h 500 -w 1200 -a PNG \
  --imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
  --lazy --start -2592000 --end -7200 \
  -v "Round-Trip Time (ms)" \
  --rigid \
  --lower-limit 0 \
  DEF:roundtrip=ping_personal_devices_"${what}".rrd:rtt:AVERAGE \
  AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
  GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
  GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
  GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
  GPRINT:roundtrip:MIN:"Min\: %5.2lf"

  rrdtool graph ping_personal_devices_"${what}"_year.png \
  --imginfo '<IMG SRC=/stats/%s WIDTH=%lu HEIGHT=%lu >' \
  --lazy --start -31536000 --end -86400 -h 500 -w 1200 -a PNG \
  -v "Round-Trip Time (ms)" \
  --rigid \
  --lower-limit 0 \
  DEF:roundtrip=ping_personal_devices_"${what}".rrd:rtt:AVERAGE \
  AREA:roundtrip#4444ff:"Round Trip Time (millis)" \
  GPRINT:roundtrip:LAST:"Cur\: %5.2lf" \
  GPRINT:roundtrip:AVERAGE:"Avg\: %5.2lf" \
  GPRINT:roundtrip:MAX:"Max\: %5.2lf" \
  GPRINT:roundtrip:MIN:"Min\: %5.2lf"

done

