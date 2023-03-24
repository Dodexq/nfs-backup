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
* Установлен стек Prometheus + Grafana `http://192.168.0.32:9090/` && `http://192.168.0.32:3000/ (Host: prom-grafana-server) (Public IP: http://5.3.173.222:3000/ login: admin, pass: Admin4grafana#)`


## env:
`DIR_TO_BACKUP` - изначальна дирректория бекапа (откуда будет производиться бекабирование)

`DIR_TO_NFS_WEEKLY` - путь укладки еженедельного бекапа 

`DIR_TO_NFS_MONTHLY` - путь укладки ежемесячного бекапа

`DAY_OF_WEEK` - в какой день недели производить бекап (1..7)

`DAY_OF_MONTH` - в какой день месяца ротация бекапа (01..30)