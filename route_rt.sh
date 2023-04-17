#!/bin/bash
ifconfig eth1 192.168.1.31/24
ip route add  192.168.1.0/24 dev eth1
route add default gw 192.168.1.1
