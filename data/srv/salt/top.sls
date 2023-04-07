base:
  '*':
    - node-exporter.node-exporter-install

  'prom-grafana-server':
    - test_apt.nginx_install
  
  'gitlab-server'
    - backup_exporter.exporter_install
    - backup_exporter.backup_universal_cron_install
    - backup_gitlab.backup_gitlab_with_config_install