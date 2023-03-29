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
    - names:
        - /usr/local/bin/backup_exporter
    - source: salt://backup-exporter/backup_exporter

copy_systemd_config_default:
  file.managed:
    - mode: '0555'
    - names:
      - /etc/systemd/system/backup_exporter.service:
        - source: salt://backup-exporter/backup_exporter.service


service-backup-exporter-enable:
  service.enabled:
    - name: backup_exporter

service-backup-exporter-start:
  service.running:
    - name: backup_exporter


