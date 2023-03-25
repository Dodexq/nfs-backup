sudo apt update
sudo apt upgrade -y
sudo apt install net-tools -y
## Auto mount nfs folder
sudo mkdir -p /nfs/backups
sudo cp /vagrant/data/etc/systemd/system/nfs-backups.mount /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start nfs-backups.mount
sudo systemctl enable nfs-backups.mount
## Install Weekly and mounthly backups cron job
sudo cp /vagrant/data/etc/crontab /etc/
sudo cp /vagrant/data/cron/backup-universal.sh /etc/cron.d/
sudo systemctl restart cron
## Install dependency
echo "postfix postfix/mailname string gitlab.local" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Gitlab'" | sudo debconf-set-selections
sudo apt install ca-certificates curl openssh-server postfix tzdata perl -y
## Install gitlab
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt install gitlab-ce=15.9.3-ce.0 -y
## Configure Gitlab (u: root p: qwehjkzxc!)
sudo cp /vagrant/data/etc/gitlab/gitlab.rb /etc/gitlab/
sudo gitlab-ctl reconfigure
## Install salt minion
sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004 focal main" | sudo tee /etc/apt/sources.list.d/salt.list
sudo apt update
sudo apt-get install salt-minion -y
## Connect salt-minion to salt-master
sudo cp /vagrant/data/etc/salt/minion /etc/salt/
sudo systemctl restart salt-minion.service