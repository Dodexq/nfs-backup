# Watcher Prometheus configuration files

{% set prometheus_dir = '/etc/prometheus' %}

# Copy prometheus config file
copy_prom_config:
  file.managed:
    - name: {{ prometheus_dir }}/prometheus.yml
    - source: salt://prometheus/prometheus/prometheus.yml
    - user: root
    - group: root
    - mode: '0644'

# Copy alert rules file
copy_alert_rules:
  file.managed:
    - name: {{ prometheus_dir }}/alerts.yml
    - source: salt://prometheus/prometheus/alerts.yml
    - user: root
    - group: root
    - mode: '0644'

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