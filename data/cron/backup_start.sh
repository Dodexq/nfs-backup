#!/bin/bash
backuppath="/var/opt/gitlab/backups/"
lastbackup="$(sudo ls -al "$backuppath" | tail -1 | awk '{print $9}')"
fulpath="$backuppath$lastbackup"
datenow="$(date +%d-%m-%y)"
sudo gitlab-backup create
sleep 1s
sudo cp "$fulpath" "/nfs/backups/$datenow-gitlab-backup.tar"
echo "Backup copy to nfs successful: /nfs/backups/$datenow-gitlab_backup.tar"