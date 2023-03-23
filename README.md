## Автоматизированное еженедельное бекабирование, с ежемесечной ротацией архивов (на примере Gitlab), с подключением NFS шары, и алертинга нестандартных ситуаций в стек Prometheus + Grafana, с раскаткой через SaltStack

### VM:
1) NFS-server `192.168.0.30`
2) Gitlab `192.168.0.31`
3) Prometheus + Grafana `192.168.0.32`
4) Salt-master `192.168.0.33`

```
vagrant up --provision
```
## Provision
* Настроен exports на NFS
* При развертывании шара смонтирована на VM Gitlab `/nfs/backups/`
* Уложен скрипт и Cron `0 0 * * * root /etc/cron.d/backup-universal.sh`


## env:
`DIR_TO_BACKUP` - изначальна дирректория бекапа (откуда будет производиться бекабирование)

`DIR_TO_NFS_WEEKLY` - путь укладки еженедельного бекапа 

`DIR_TO_NFS_MONTHLY` - путь укладки ежемесячного бекапа

`DAY_OF_WEEK` - в какой день недели (1..7) производить бекап

`DAY_OF_MONTH` - в какой день месяца ротация бекапа