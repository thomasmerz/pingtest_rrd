#!/bin/bash

cd ~/dev/pingtest_rrd/ || exit 1

dev_int='192.168.0.1 192.168.0.2 192.168.0.3'
dev_ext='heise.de spiegel.de startpage.com'
for devices in $dev_int $dev_ext; do
  cp -af index_template.html index_"$devices".html
  sed -i "s/192.168.0.1/$devices/g" index_"$devices".html
done

