node_exporter_tar:
  archive.extracted:
    - name: /tmp/node_exporter
    - source: https://github.com/Dodexq/elk-prometheus-metrics/raw/main/userdata/node-exporter/nonode_exporter-1.3.1.linux-amd64.tar.gz
    - user: root
    - group: root
    - archive_format: tar
    - tar_options: '-xzf'
    - keep: False
    - skip_verify: True

node_exporter_bin:
  file.copy:
    - name: /usr/sbin/node_exporter
    - source: /tmp/node_exporter/node_exporter-1.3.1.linux-amd64/node_exporter
    - user: root
    - group: root
    - mode: '0744'


/etc/systemd/system/node_exporter.service:
  file.managed:
    - source: salt://data/node_exporter.service
    - user: root
    - group: root
    - mode: '0744'


node_exporter_enable:
  service.running:
    - name: node_exporter.service
    - enable: True