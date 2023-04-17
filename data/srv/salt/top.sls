base:
  '*':
    - node-exporter.node-exporter-install

  'prom-grafana-server':
    - test_apt.nginx_install
    - prometheus.cron_watcher_config_install
  
  'gitlab-server':
    - backup_exporter.backup_universal_cron_install
    - backup_gitlab.backup_gitlab_with_config_install
    - backup_exporter.exporter_install

  'salt-server':
    - salt_exporter.salt_exporter_install

  'mini-vm':
    - test_apt.nginx_install