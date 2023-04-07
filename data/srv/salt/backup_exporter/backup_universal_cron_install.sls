copy_script_to_cron_dir:
    file.managed:
    - name: /etc/cron.d/backup-universal.sh
    - source: salt://backup_exporter/backup_universal/backup_universal.sh
    - user: root
    - group: root
    - mode: 0555

setup_cron_job:
    cron.present:
    - name: /etc/cron.d/backup-universal.sh
    - user: root
    - minute: '0'
    - hour: '0'
    - daymonth: '*'
    - month: '*'
    - dayweek: '*'

cron_dir_to_backup:
    cron.env_present:
    - user: root
    - name: DIR_TO_BACKUP
    - value: /var/opt/gitlab/backups/