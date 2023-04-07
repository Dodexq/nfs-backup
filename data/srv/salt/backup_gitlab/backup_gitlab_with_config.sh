#!/bin/bash
# Backup GitLab with Config

BACKUP_DIR="/var/opt/gitlab/backups"
GITLAB_CONFIG="/etc/gitlab/"

# Backup GitLab config
echo "Start Backup configuration files to $BACKUP_DIR"
tar czf "$BACKUP_DIR/$(date +%Y-%m-%d-%H-%M-%S)_gitlab_config.tar" --absolute-names $GITLAB_CONFIG

# Backup GitLab
echo "Start Backup gitlab-backup to $BACKUP_DIR"
gitlab-backup create SKIP=registry

# Tar GitLab backup and Gitlab Config
ALL_TAR_BACKUP="$(find $BACKUP_DIR/*.tar -type f -print0 | xargs -0)"
echo "Start Backup configuration and gitlab-backup in folder $BACKUP_DIR"
cd $BACKUP_DIR 
tar czf "$BACKUP_DIR/$(date +%Y-%m-%d-15.9.3)_gitlab_backup.tar.gz" *.tar
rm $BACKUP_DIR/*.tar