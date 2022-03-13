# Purpose of this project
This project implement a nice monitoring of average pings to IP adresses / hostnames in RRD databases and simple HTML pages with PNG graphs. With these information you know when your devices at home or external hosts are up/down and how fast they respond to your pings. You can also get correlations when both internal/router IP and external hosts are "down" - this might be due to your router/provider.  

![image]()
(Router 192.168.0.1 Daily Round-Trip & Packetloss Stats(5min average))  

vs.  

![image]()
(external host Daily Round-Trip & Packetloss Stats(5min average) with a short downtime on provider's (ISP) site / router reboot)  
There are the following scripts that are doing the following:

```
# for your infrastructiure (router, etc.) and/or external hosts:
01_ping.sh
02_ping-graph.sh
98_create_html.sh
98_create_rrd.sh
# for your personal devices (printer, ipad(s), iphone(s), consoles, etc.)
01_ping_personal_devices.sh
02_ping-graph_personal_devices.sh
98_create_html_personal_devices.sh
98_create_rrd_personal_devices.sh
```

## 01_ping.sh / 01_ping_personal_devices.sh
Run this script periodically (for example every 5 minutes) via crontab to monitor some IP addresses / hostss. All results are written into RRD database(s).  

🚧 You have to check and edit [internal_network](01_ping.sh#L35) and [external_network](01_ping.sh#L47) and [personal_devices] (01_ping_personal_devices.sh#35) in these files!

## 02_ping-graph.sh / 02_ping-graph_personal_devices.sh
Run this script periodically (for example every hour) via crontab to create PNG-chart(s) from results RRD database(s) for hourly/daily/weekly/monthly/yearly charts.

🚧 You have to check and edit [h_int/h_ext](02_sping-graph.sh#L5-L6) and [h](02_ping-graph_personal_devices.sh#L5) in this file!

## 98_create_html.sh / 98_create_html_personal_devices.sh
Run this script once to copy and edit html-files from template for all DNS resolvers that are "configured" in this script.  

🚧 You have to check and edit [dev_int/dev_ext](98_create_html.sh#L5-L6) and [what](98_create_html_personal_devices.sh#L5) in this file!

## 98_create_rrd.sh / 98_create_rrd_personal_devices.sh
Run this script once to create rrd-database-files all DNS resolvers that are "configured" in this script.  

🚧 You have to check and edit [what_int/what_ext](98_create_rrd.sh#L21-L22) and [what](98_create_rrd_personal_devices.sh#L5) in this file!

## Crontab
```
# this is my pingtest:
*/5 * * * * ~/dev/pingtest_rrd/01_ping.sh >/dev/null
0   * * * * ~/dev/pingtest_rrd/02_ping-graph.sh >/dev/nul
```

## Examples
I've uploaded some real-world [examples](examples) from my home-network monitored via Wifi behind a range-extender with a [router cascade](https://www.heise.de/ct/artikel/Router-Kaskaden-1825801.html?view=print):  
```
192.168.0.1 = this is my ISP's router  
192.168.42.1 = this is my private router directly connected via LAN  
192.168.42.2 = this is my range-extender (to enlarge wifi-availability in my very long flat where ISP/router is set on the one end and "office" is located on the very other end) - this is where my linux machine is connected directly via LAN to  
hetzner_hel1_dc2_fi = this is a [Hetzner-Cloudserver](https://www.hetzner.com/de/cloud) located in Helsinki, Finland
hetzner_nbg1_dc3_de = this is a [Hetzner-Cloudserver](https://www.hetzner.com/de/cloud) located in Nuremberg, Germany
```
So all packets have to go this way:  
`Linux machine -> 192.168.42.2 -> 192.168.42.1 -> 192.168.0.1 -> Internet / Hetzner`

Have fun!

