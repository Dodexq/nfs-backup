base:	
  '*':
    node-exporter.node-exporter-install
  
  'gitlab-server':
  	universal-backup-cron.install

  'prom-grafana-server':
  	backup-exporter.install
