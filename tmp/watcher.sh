#!/bin/bash

if [ -e /etc/prometheus/timestamp ]; then
	if [[ $(stat -c %Y /etc/prometheus/prometheus.yml) -gt $(cat /etc/prometheus/timestamp) ]]; then
		echo $(stat -c %Y /etc/prometheus/prometheus.yml) > /etc/prometheus/timestamp
    	curl -XPOST http://127.0.0.1:9090/-/reload
    	echo "Prometheus configuration reload!"
	fi
else
	echo $(stat -c %Y /etc/prometheus/prometheus.yml) > /etc/prometheus/timestamp
fi