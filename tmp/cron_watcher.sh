#!/bin/bash
PROMETHEUS_PATH="/etc/prometheus"

if [ -e /etc/prometheus/.timestamp_prometheus ] && [ -e /etc/prometheus/.timestamp_alerts ] ; then
	if [[ $(stat -c %Y $PROMETHEUS_PATH/prometheus.yml) -gt $(cat $PROMETHEUS_PATH/.timestamp_prometheus) ]] \
		|| [[ $(stat -c %Y $PROMETHEUS_PATH/alerts.yml) -gt $(cat $PROMETHEUS_PATH/.timestamp_alerts) ]] ; then
		echo $(stat -c %Y $PROMETHEUS_PATH/prometheus.yml) > $PROMETHEUS_PATH/.timestamp_prometheus
    	echo $(stat -c %Y $PROMETHEUS_PATH/alerts.yml) > $PROMETHEUS_PATH/.timestamp_alerts
    	curl -XPOST http://127.0.0.1:9090/-/reload
    	echo "Prometheus configuration reload!"
	fi
else
	echo $(stat -c %Y $PROMETHEUS_PATH/prometheus.yml) > $PROMETHEUS_PATH/.timestamp_prometheus
	echo $(stat -c %Y $PROMETHEUS_PATH/alerts.yml) > $PROMETHEUS_PATH/.timestamp_alerts
fi
