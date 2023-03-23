#!/bin/bash
echo "Start weekly backup"
sudo gitlab-backup create
bpath=/var/opt/gitlab/backups/
nfspath=/nfs/backups/weekly/
blast="$(sudo ls -l "$bpath" | tail -1 | awk '{print $9}')"
## Get all files in folder: allfiles="$(find $PATH -type f -print0 | xargs -0)"
fullbpath=$bpath$blast
datenow="$(date +%d-%m-%y)"
fullnewpath="$nfspath"gitlab-backup-$datenow.tar
echo $blast
sudo cp $fullbpath $fullnewpath

if [ -f "$fullnewpath" ]; then
	echo "Backup copy to nfs successful: $fullnewpath"
	echo "Delete temporary backup"
	sudo rm $fullbpath
else
    echo "Backup failed! $fullnewpath does not exist"
fi