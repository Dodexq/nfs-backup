sudo apt update
sudo apt upgrade -y
## Auto mount nfs folder
sudo mkdir -p /nfs/backups
sudo cp /vagrant/data/etc/systemd/system/nfs-backups.mount /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start nfs-backups.mount
sudo systemctl enable nfs-backups.mount
## Install Weekly and mounthly backups cron job
sudo cp /vagrant/data/etc/crontab /etc/
sudo cp /vagrant/data/cron/monthly-backup.sh /etc/cron.d/ && sudo cp /vagrant/data/cron/weekly-backup.sh /etc/cron.d/
sudo systemctl restart cron
## Install dependency
echo "postfix postfix/mailname string gitlab.local" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Gitlab'" | sudo debconf-set-selections
sudo apt install ca-certificates curl openssh-server postfix tzdata perl -y
## Install gitlab
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh
sudo apt install gitlab-ce -y
## Configure Gitlab (u: root p: qwehjkzxc!)
sudo cp /vagrant/data/etc/gitlab/gitlab.rb /etc/gitlab/
sudo gitlab-ctl reconfigure