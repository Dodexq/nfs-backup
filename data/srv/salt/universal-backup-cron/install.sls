copy_script_to_cron_dir:
    file.managed:
    - name: /etc/cron.d/backup-universal.sh
    - source: salt://universal-backup-cron/backup-universal.sh
    - user: root
    - group: root
    - mode: 0555

setup_cron_job:
    cron.present:
    - name: /etc/cron.d/backup-universal.sh
    - user: root
    - minute: '*/2'
    - hour: '*'
    - daymonth: '*'
    - month: '*'
    - dayweek: '*'

setup_env_vars:
    cron.env_present:
    - user: root
    - name: 
        - 'DIR_TO_NFS_WEEKLY'
        - 'DAY_OF_WEEK' 
    - value: 
        - '/home/vagrant'
        - '3'