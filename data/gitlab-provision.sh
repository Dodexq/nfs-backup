sudo apt update
sudo apt upgrade -y
## Auto mount nfs folder
sudo mkdir -p /nfs/backup
sudo cp /vagrant/data/etc/fstab /etc/