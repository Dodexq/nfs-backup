# Еженедельное бекабирование, с ежемесечной ротацией архивов (на примере Gitlab), и алертинга нестандартных ситуаций в стек Prometheus + AlertManager, с раскаткой через SaltStack

## Установка
1. `cron_init` - Копирование скрипта в директорию `/etc/cron.d/` и установка cron job `0 0 * * *` (каждый день в 00:00)
2. `install` - Установка GO демона `backup-exporter`

## Конфигурация

### Переменные скрипта (имеет дефолтные значения, если env не задан)
`./backup_universal.sh`

`DIR_TO_BACKUP` - изначальна дирректория бекапа (откуда будет производиться бекабирование)

`DIR_TO_NFS_WEEKLY` - путь укладки еженедельного бекапа 

`DIR_TO_NFS_MONTHLY` - путь укладки ежемесячного бекапа

`DAY_OF_WEEK` - в какой день недели производить бекап (1..7)

`DAY_OF_MONTH` - в какой день месяца ротация бекапа (01..30)

`EXPORTER_URL` - URL backup-exporter

### Установка собственных env (на примере DAY_OF_MONTH)
`./cron_init.sls`
```
cron_day_of_month:
    cron.env_present:
    - user: root
    - name: DAY_OF_MONTH
    - value: 29
```
### Конфигурация дня проверки
`./cron_init.sls`
```
setup_cron_job:
    cron.present:
    - name: /etc/cron.d/backup-universal.sh
    - user: root
    - minute: '0'
    - hour: '0'
    - daymonth: '*'
    - month: '*'
    - dayweek: '*'

```
### Проверить cron правила
```
cat /var/spool/cron/crontabs/root
```
### Логи срабатывания cron
```
cat /var/mail/root
```

### Конфигурация Alert Groups для Prometheus
`./backup_alerts.yml`
```
expr: changes(weekly_backups_total{job="backup-exporter"}["дней, перед pending]) < 1
for: (дней после pending, перед alert)
```
### Конфигурация GO exporter

#### Счетчики

`./main.go`

```
	// Create new Prometheus counters for weekly and monthly backups
	weeklyBackups := prometheus.NewCounter(prometheus.CounterOpts{
		Name: "weekly_backups_total",
		Help: "Number of weekly backups",
	})
	monthlyBackups := prometheus.NewCounter(prometheus.CounterOpts{
		Name: "monthly_backups_total",
		Help: "Number of monthly backups",
	})

	// Register the metrics with the Prometheus collector
	prometheus.MustRegister(weeklyBackups, monthlyBackups)

```
#### Обращение по URL

`./main.go`

```
switch r.URL.Path {
		case "/weeklyBackupsInc":
			weeklyBackups.Inc()
		case "/monthlyBackupsInc":
			monthlyBackups.Inc()
}
```

### Grafana Dashboard
`./backup-grafana-dashboard.json`