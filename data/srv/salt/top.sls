base:	
  '*':
    node-exporter.node-exporter-install
  
  'gitlab-server':
  	universal-backup-cron.install
  	backup-exporter.install