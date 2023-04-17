# Cron watcher Prometheus configuration files

{% set prometheus_dir = '/opt/prom-stack/prometheus' %}

# Copy prometheus config file
copy_prom_config:
  file.managed:
    - name: {{ prometheus_dir }}/prometheus.yml
    - source: salt://prometheus/prometheus_config/prometheus.yml
    - user: root
    - group: root
    - mode: '0555'

# Copy alert rules file
copy_alert_rules:
  file.managed:
    - name: {{ prometheus_dir }}/alert.rules
    - source: salt://prometheus/prometheus_config/alert.rules
    - user: root
    - group: root
    - mode: '0555'

watch_to_prom_config:
  cmd.wait:
    - name: curl -XPOST http://127.0.0.1:9090/-/reload
    - watch:
      - file: copy_prom_config

watch_to_alert_rules:
  cmd.wait:
    - name: curl -XPOST http://127.0.0.1:9090/-/reload
    - watch:
      - file: copy_alert_rules