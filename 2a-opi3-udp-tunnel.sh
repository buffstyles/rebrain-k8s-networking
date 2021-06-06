#!/bin/bash
set -x
iptables -P FORWARD ACCEPT
modprobe fou
ip fou add port 9000 ipproto 4
ip link add name tunudp type ipip remote 192.168.2.1 local 192.168.2.212 encap fou encap-sport auto encap-dport 9000
ip link set tunudp up
ip link set tunl0 up
ip r a 192.168.1.0/24 dev tunudp scope link src 192.168.2.212
sysctl -w net.ipv4.conf.tunudp.rp_filter=0
sysctl -w net.ipv4.conf.wlan0.rp_filter=0
sysctl -w net.ipv4.conf.tunl0.rp_filter=0
sysctl -w net.ipv4.conf.default.rp_filter=0
sysctl -w net.ipv4.conf.all.rp_filter=0
sysctl -w net.ipv4.ip_forward=1
