#!/bin/bash
sudo gitlab-backup create
bpath=/var/opt/gitlab/backups/
blast="$(sudo ls -l "$bpath" | tail -1 | awk '{print $9}')"
fullpath=$bpath$blast
datenow="$(date +%d-%m-%y)"
sudo cp $fullpath /nfs/backups/weekly/$datenow-gitlab-backup.tar
echo "Backup copy to nfs successful: /nfs/backups/weekly/gitlab-backup-$datenow.tar"
sudo rm $fullpath
echo "Delete temporary backup"