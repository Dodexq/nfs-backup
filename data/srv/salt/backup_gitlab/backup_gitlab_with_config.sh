#!/bin/bash
# Backup GitLab with Config

BACKUP_DIR="/var/opt/gitlab/backups"
GITLAB_CONFIG="/etc/gitlab/"
GITLAB_VERSION=$(awk '/gitlab_version/ {print $2}' /var/opt/gitlab/backups/backup_information.yml)

# Backup GitLab config
echo "Start Backup configuration files to $BACKUP_DIR"
tar czf "$BACKUP_DIR/$(date +%Y-%m-%d)_gitlab_config.tar" --absolute-names $GITLAB_CONFIG

# Backup GitLab
echo "Start Backup gitlab-backup to $BACKUP_DIR"
gitlab-backup create INCREMENTAL=yes SKIP=artifacts,tar

# Tar GitLab backup and Gitlab Config
ALL_TAR_BACKUP="$(find $BACKUP_DIR/*.tar -type f -print0 | xargs -0)"
echo "Start Backup configuration and gitlab-backup in folder $BACKUP_DIR"
cd $BACKUP_DIR 
tar czf "$BACKUP_DIR/$(date +%Y-%m-%d-$GITLAB_VERSION)_gitlab_backup.tar" *
rm *_gitlab_config.tar