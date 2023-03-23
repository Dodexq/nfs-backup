#!/bin/bash
# env $DIR_TO_BACKUP $DIRS_TO_NFS $DAY_OF_WEEK $MONTHLY_BACKUP
ALL_FILES="$(find $DIR_TO_BACKUP -type f -print0 | xargs -0)"

backup() {
  for FILE in $ALL_FILES; do
    cp $DIR_TO_BACKUP" "DIRS_TO_NFS
  done
}

# Rotate backups
rotate_backups() {
  # Find the backups older than a month
  BACKUPS_TO_DELETE=$(find /mnt/backups -maxdepth 1 -type d -mtime +30 -exec basename {} \;)

  # Delete the backups
  for BACKUP in $BACKUPS_TO_DELETE; do
    rm -rf "/mnt/backups/$BACKUP"
  done
}

# Create backups once a week
if [ $DAY_OF_WEEK -eq 0 ]; then
  backup()
fi

# Rotate backups once a month
if [ $MONTHLY_BACKUP -eq 1 ]; then
  rotate_backups
fi