#!/bin/bash
ifconfig eth0 192.168.29.1 netmask 255.255.255.0;
route add -net 192.168.29.0/24 dev eth0;
echo 1 > /proc/sys/net/ipv4/ip_forward;
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE;
ifconfig eth0 up;
exit 0;
