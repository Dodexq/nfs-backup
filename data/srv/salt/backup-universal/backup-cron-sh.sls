copy_script_to_cron_dir:
  file.managed:
    - name: /etc/cron.d/backup-universal.sh
    - source: salt://backup-universal/backup-universal.sh
    - user: root
    - group: root
    - mode: 744

setup_cron_job:
  cron.present:
    - name: /etc/cron.d/backup-universal.sh
    - user: root
    - minute: 0
    - hour: 0
    - daymonth: '*'
    - month: '*'
    - dayweek: '*'