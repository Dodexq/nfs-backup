#!/bin/bash
wbpath=/nfs/backups/weekly/
mbpath=/nfs/backups/monthly/
wblast="$(sudo ls -ltr $wbpath | tail -1 | awk '{print $9}')"
datenow="$(date +%d-%m-%y)"
fullpath=$wbpath$wblast
sudo mv $fullpath $mbpath
echo "Move monthly backup path: $mbpath$wblast"
allwb="$(find $wbpath -type f -print0 | xargs -0)"
sudo rm $allwb
echo "Weekly backup clear: $allwb"