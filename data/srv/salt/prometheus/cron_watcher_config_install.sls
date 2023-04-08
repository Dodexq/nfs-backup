# Cron watcher Prometheus configuration files

copy_script_cron_watcher:
    file.managed:
    - name: /etc/cron.d/cron_watcher.sh
    - source: salt://prometheus/cron_watcher.sh
    - user: root
    - group: root
    - mode: 0555

setup_cron_watcher:
    cron.present:
    - name: /etc/cron.d/cron_watcher.sh
    - user: root
    - minute: '*/1'
    - hour: '*'
    - daymonth: '*'
    - month: '*'
    - dayweek: '*'