sudo apt update
sudo apt upgrade -y
sudo apt install net-tools -y
## nfs-server install
sudo apt install nfs-kernel-server -y
sudo mkdir -p /var/nfs/backups/weekly && sudo mkdir -p /var/nfs/backups/weekly
sudo cp /vagrant/data/etc/exports /etc/exports
sudo systemctl restart nfs-kernel-server

