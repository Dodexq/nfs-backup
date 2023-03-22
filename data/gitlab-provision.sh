sudo apt update
sudo apt upgrade -y
## Auto mount nfs folder
sudo mkdir -p /nfs/backup
sudo cp /vagrant/data/etc/fstab /etc/
## Install dependency
echo "postfix postfix/mailname string gitlab.local" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Gitlab'" | sudo debconf-set-selections
sudo apt install ca-certificates curl openssh-server postfix tzdata perl -y
## Install gitlab
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash /tmp/script.deb.sh
sudo apt install gitlab-ce -y
## Configure Gitlab
sudo cp /vagrant/data/etc/gitlab/gitlab.rb /etc/gitlab/
sudo gitlab-ctl reconfigure