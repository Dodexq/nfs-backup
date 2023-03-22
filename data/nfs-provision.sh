sudo apt update
sudo apt upgrade -y

## nfs-server install
sudo apt install nfs-kernel-server -y
sudo mkdir -p /var/nfs/backups
sudo chown nobody:nogroup /var/nfs/backups
sudo cp /vagrant/data/etc/exports /etc/exports
sudo systemctl restart nfs-kernel-server

