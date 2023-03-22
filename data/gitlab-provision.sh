sudo apt update
sudo apt upgrade -y
## Auto mount nfs folder
sudo mkdir -p /nfs/backups
sudo cp /vagrant/data/etc/systemd/system/nfs-backup.mount /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start nfs-backup.mount
sudo systemctl enable nfs-backup.mount
## Install dependency
echo "postfix postfix/mailname string gitlab.local" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Gitlab'" | sudo debconf-set-selections
sudo apt install ca-certificates curl openssh-server postfix tzdata perl -y
## Install gitlab
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh
sudo apt install gitlab-ce -y
## Configure Gitlab (u: root p: example-pass)
sudo cp /vagrant/data/etc/gitlab/initial_root_password /etc/gitlab/
sudo cp /vagrant/data/etc/gitlab/gitlab.rb /etc/gitlab/
sudo ln -s /nfs/backups /var/opt/gitlab 
sudo gitlab-ctl reconfigure