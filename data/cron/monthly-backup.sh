#!/bin/bash
echo "Start monthly GitLab backup"
wbpath=/nfs/backups/weekly/
mbpath=/nfs/backups/monthly/
wblast="$(sudo ls -ltr $wbpath | tail -1 | awk '{print $9}')"
datenow="$(date +%d-%m-%y)"
fullbpath=$wbpath$wblast
sudo cp $fullbpath $mbpath
echo "Copy monthly backup path: $mbpath$wblast"
allwb="$(find $wbpath -type f -print0 | xargs -0)"

if [ -f "$mbpath$wblast" ]; then
	sudo rm $allwb
	echo "Weekly backup remove: $allwb"
else
    echo "Monthly Backup failed! $mbpath$wblast does not exist"
fi