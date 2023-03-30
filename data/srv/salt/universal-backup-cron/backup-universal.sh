#!/bin/bash
# env $DIR_TO_BACKUP $DIR_TO_NFS_WEEKLY $DIR_TO_NFS_MONTHLY $DAY_OF_WEEK (1..7) $DAY_OF_MONTH day of month (01..30)

# Set default values
DIR_TO_BACKUP="${DIR_TO_BACKUP:=/var/opt/gitlab/backups}"
DIR_TO_NFS_WEEKLY="${DIR_TO_NFS_WEEKLY:=/nfs/backups/weekly}"
DIR_TO_NFS_MONTHLY="${DIR_TO_NFS_MONTHLY:=/nfs/backups/monthly}"
DAY_OF_WEEK="${DAY_OF_WEEK:=7}"
DAY_OF_MONTH="${DAY_OF_MONTH:=01}"

# Parse command-line arguments
OPTIONS=$(getopt -n $0 -o a:b:c:d:e: --long DIR_TO_BACKUP:,DIR_TO_NFS_WEEKLY:,DIR_TO_NFS_MONTHLY:,DAY_OF_WEEK:,DAY_OF_MONTH: -- "$@")
if [ $? -ne 0 ]; then
  exit 1
fi
eval set -- "$OPTIONS"
while true; do
  case "$1" in
    -a|--DIR_TO_BACKUP)
      DIR_TO_BACKUP="$2"
      shift 2;;
    -b|--DIR_TO_NFS_WEEKLY)
      DIR_TO_NFS_WEEKLY="$2"
      shift 2;;
    -c|--DIR_TO_NFS_MONTHLY)
      DIR_TO_NFS_MONTHLY="$2"
      shift 2;;
    -d|--DAY_OF_WEEK)
      DAY_OF_WEEK="$2"
      shift 2;;
    -e|--DAY_OF_MONTH)
      DAY_OF_MONTH="$2"
      shift 2;;
    --)
      shift
      break;;
    *)
      echo "Unknown option: $1"
      exit 1;;
  esac
done

# Check if all arguments are provided
if [ -z "$DIR_TO_BACKUP" ] || [ -z "$DIR_TO_NFS_WEEKLY" ] || [ -z "$DIR_TO_NFS_MONTHLY" ] || [ -z "$DAY_OF_WEEK" ] || [ -z "$DAY_OF_MONTH" ]; then
  echo "Usage: $0 -a DIR_TO_BACKUP -b DIR_TO_NFS_WEEKLY -c DIR_TO_NFS_MONTHLY -d DAY_OF_WEEK -e DAY_OF_MONTH"
  exit 1
fi


backup() {
  ALL_BACKUP="$(find $DIR_TO_BACKUP -type f -print0 | xargs -0)"
  if [[ ! -z "$ALL_BACKUP" ]]; then
    for FILE in $ALL_BACKUP; do
      cp $FILE $DIR_TO_NFS_WEEKLY
      if [ -e $DIR_TO_NFS_WEEKLY/$(basename "$FILE") ]; then
        rm $FILE
        echo "Weekly backup done: to NFS folder: $DIR_TO_NFS_WEEKLY/$(basename "$FILE")"
      else
        echo "ERROR: Weekly backup not copied to folder: $DIR_TO_NFS_WEEKLY/"
      fi
    done
    curl http://192.168.0.32:9950/weeklyBackupsInc
  else
    echo "ERROR: $DIR_TO_BACKUP/ is empty, Backup not create"
  fi
}

rotate_backups() {
  LAST_BACKUP="$(ls -t $DIR_TO_NFS_WEEKLY | head -1)"
  if [[ ! -z "$LAST_BACKUP" ]]; then
    ALL_BACKUP_WEEK="$(find $DIR_TO_NFS_WEEKLY -type f -print0 | xargs -0)"
    cp $DIR_TO_NFS_WEEKLY/$LAST_BACKUP $DIR_TO_NFS_MONTHLY
    if [[ -e "$DIR_TO_NFS_MONTHLY/$LAST_BACKUP" ]]; then
      echo "Monthly backup done. Last backup: $DIR_TO_NFS_MONTHLY/$LAST_BACKUP"
      for FILE in $ALL_BACKUP_WEEK; do
        rm $FILE
      done
      curl http://192.168.0.32:9950/monthlyBackupsInc
    else
      echo "ERROR: Monthly Backup in $DIR_TO_NFS_MONTHLY/ not exists"
    fi
  else
    echo "ERROR: Weekly Backups in $DIR_TO_NFS_WEEKLY/ not exists" 
  fi
}

# Create backups once a week (%u - day of week (1..7); 1 is Monday)
if [ "$(date +%u)" -eq $DAY_OF_WEEK ]; then
  backup
else 
  echo "Weekly backup not today"
fi

# Rotate backups once a month (01..30)
if [ "$(date +%d)" -eq $DAY_OF_MONTH ]; then
  rotate_backups
else 
  echo "Monthly backup not today"
fi

