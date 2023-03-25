sudo apt update
sudo apt upgrade -y
sudo apt install net-tools -y
## Install nfs-server 
sudo apt install nfs-kernel-server -y
sudo mkdir -p /var/nfs/backups/weekly && sudo mkdir -p /var/nfs/backups/weekly
sudo cp /vagrant/data/etc/exports /etc/exports
sudo systemctl restart nfs-kernel-server
## Install salt minion
sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004 focal main" | sudo tee /etc/apt/sources.list.d/salt.list
sudo apt update
sudo apt-get install salt-minion -y
## Connect salt-minion to salt-master
sudo cp /vagrant/data/etc/salt/minion /etc/salt/
sudo systemctl status salt-minion.service