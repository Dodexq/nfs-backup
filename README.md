## Автоматизированное еженедельное бекабирование, с ежемесечной ротацией архивов (на примере Gitlab), с подключением NFS шары, и алертинга нестандартных ситуаций в стек Prometheus + Grafana, с раскаткой через SaltStack

### VM:
1) NFS-server `192.168.0.30` Host: `nfs-server`
2) Gitlab `192.168.0.31` Host: `gitlab-server`
3) Prometheus + Grafana `192.168.0.32` Host: `prom-grafana-server`
4) Salt-master `192.168.0.33` Host: `salt-server`

### Первый запуск только с VPN!
```
vagrant up --provision
```
## Provision
* Настроен exports на NFS
* При развертывании шара смонтирована на VM Gitlab `/nfs/backups/`
* Уложен скрипт и Cron `0 0 * * * root /etc/cron.d/backup-universal.sh`
* Установлен стек Prometheus + Grafana `http://192.168.0.32:9090/` && `http://192.168.0.32:3000/ (Host: prom-grafana-server) (Public IP: http://109.106.138.175:3000 login: admin, pass: Admin4grafana#)`


## env:
`DIR_TO_BACKUP` - изначальна дирректория бекапа (откуда будет производиться бекабирование)

`DIR_TO_NFS_WEEKLY` - путь укладки еженедельного бекапа 

`DIR_TO_NFS_MONTHLY` - путь укладки ежемесячного бекапа

`DAY_OF_WEEK` - в какой день недели производить бекап (1..7)

`DAY_OF_MONTH` - в какой день месяца ротация бекапа (01..30)

## SaltStack
Salt-minion уже развернут на всех VM. Для accept Key for minion на salt-server: `sudo salt-key -L` - список подключенных minion агентов. `sudo salt-key -A` принять агентов.
```
Accepted Keys:
gitlab-server
nfs-server
prom-grafana-server
```
Тест: `sudo salt '*' test.ping`

## Раскатка Salt-master:
На salt-server: 

Node-exporter по всем VM: `sudo salt '*' state.apply node-exporter/node-exporter`

Cronjob backup: `sudo salt gitlab-server state.apply backup-universal/backup-cron-sh`

## Grafana
Data Sources / Prometheus - url Prometheus: `http://192.168.0.32:9090/`

Import Dashboard 1860

## Backup-exporter
Бинарник и исходник ./data/backup-exporter/backup-exporter
Порт 9950 `http://127.0.0.1:9950/`, метрики: `http://127.0.0.1:9950/metrics` weekly_backups_total и monthly_backups_total.
Инкремент: `http://127.0.0.1:9950/weeklyBackupsInc` и `http://127.0.0.1:9950/monthlyBackupsInc`   