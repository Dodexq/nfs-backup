# Backup Gtilab cron job with config in Saturday

copy_script_to_cron_dir_gitlab:
    file.managed:
    - name: /etc/cron.d/backup_gitlab_with_config.sh
    - source: salt://backup_gitlab/backup_gitlab_with_config.sh
    - user: root
    - group: root
    - mode: 0555

setup_cron_job_gitlab_backup:
    cron.present:
    - name: /etc/cron.d/backup_gitlab_with_config.sh
    - user: root
    - minute: '0'
    - hour: '0'
    - daymonth: '*'
    - month: '*'
    - dayweek: '6'