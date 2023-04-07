add_group_for_backup-exporter:
  group.present:
    - name: backup_exporter

add_user_for_backup-exporter:
  user.present:
    - name: backup_exporter
    - groups:
      - backup_exporter

copy_backup_exporter:
  file.managed:
    - mode: '0555'
    - user: backup_exporter
    - group: backup_exporter
    - name: /usr/local/bin/backup_exporter:
    - source: salt://backup_exporter/exporter/backup_exporter

copy_systemd_config_default_unique:
  file.managed:
    - name: /etc/systemd/system/backup_exporter.service:
    - source: salt://backup_exporter/exporter/backup_exporter.service
    - mode: '0555'

service-backup-exporter-enable:
  service.enabled:
    - name: backup_exporter

service-backup-exporter-start:
  service.running:
    - name: backup_exporter


