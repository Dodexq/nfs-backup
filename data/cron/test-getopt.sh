#!/bin/bash

# Set default values
DIR_TO_BACKUP="${DIR_TO_BACKUP:=/var/opt/gitlab/backups/}"
DIR_TO_NFS_WEEKLY="${DIR_TO_NFS_WEEKLY:=/nfs/backups/weekly}"
DIR_TO_NFS_MONTHLY="${DIR_TO_NFS_MONTHLY:=/nfs/backups/monthly/}"
DAY_OF_WEEK="${DAY_OF_WEEK:=7}"
DAY_OF_MONTH="${DAY_OF_MONTH:=01}"

# Parse command-line arguments
OPTIONS=$(getopt -n $0 -o a:b:c:d:e: --long DIR_TO_BACKUP:,DIR_TO_NFS_WEEKLY:,DIR_TO_NFS_MONTHLY:,DAY_OF_WEEK:,DIR_TO_NFS_WEEKLY: -- "$@")
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

# Print the arguments
echo "DIR_TO_BACKUP: $DIR_TO_BACKUP"
echo "DIR_TO_NFS_WEEKLY: $DIR_TO_NFS_WEEKLY"
echo "DIR_TO_NFS_MONTHLY: $DIR_TO_NFS_MONTHLY"
echo "DAY_OF_WEEK: $DAY_OF_WEEK"
echo "DAY_OF_MONTH: $DAY_OF_MONTH"
