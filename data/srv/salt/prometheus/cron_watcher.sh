#!/bin/bash
PROMETHEUS_PATH="/etc/prometheus"

if [ -e /etc/prometheus/timestamp ]; then
	if [[ $(stat -c %Y $PROMETHEUS_PATH/prometheus.yml) -gt $(cat $PROMETHEUS_PATH/timestamp) ]]; then
		echo $(stat -c %Y $PROMETHEUS_PATH/prometheus.yml) > $PROMETHEUS_PATH/timestamp
    	curl -XPOST http://127.0.0.1:9090/-/reload
    	echo "Prometheus configuration reload!"
	fi
else
	echo $(stat -c %Y $PROMETHEUS_PATH/prometheus.yml) > $PROMETHEUS_PATH/timestamp
fi