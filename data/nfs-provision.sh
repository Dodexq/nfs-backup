sudo apt update
sudo apt upgrade -y

## nfs-server install
sudo apt install nfs-kernel-server -y
sudo mkdir -p /var/nfs/backup 
sudo chown nobody:nogroup /var/nfs/backup
sudo cp /vagrant/data/etc/exports /etc/exports
sudo systemctl restart nfs-kernel-server

