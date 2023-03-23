#!/bin/bash
# env $DIR_TO_BACKUP $DIR_TO_NFS_WEEKLY $DIR_TO_NFS_MONTHLY $DAY_OF_WEEK (1..7) $DAY_OF_MONTH day of month (01..30)
backup() {
  ALL_BACKUP="$(find $DIR_TO_BACKUP -type f -print0 | xargs -0)"
  for FILE in $ALL_BACKUP; do
    cp $FILE $DIR_TO_NFS_WEEKLY
    echo "Weekly backup done: $FILE to NFS folder: $DIR_TO_NFS_WEEKLY"
    rm $FILE
  done
}

rotate_backups() {
  LAST_BACKUP="$(ls -t $DIR_TO_NFS_WEEKLY | head -1)"
  ALL_BACKUP_WEEK="$(find $DIR_TO_NFS_WEEKLY -type f -print0 | xargs -0)"
  cp $DIR_TO_NFS_WEEKLY/$LAST_BACKUP $DIR_TO_NFS_MONTHLY
  echo "Monthly backup done. last backup: $LAST_BACKUP"
  for FILE in $ALL_BACKUP_WEEK; do
    rm $FILE
  done
  
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