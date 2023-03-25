sudo apt update
sudo apt upgrade -y
sudo apt install net-tools -y
## Install SaltStack
sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004 focal main" | sudo tee /etc/apt/sources.list.d/salt.list
sudo apt update
sudo apt-get install salt-master -y
sudo apt-get install salt-ssh -y
## Configure salt-master
sudo cp /vagrant/data/salt/master /etc/salt/
sudo systemctl restart salt-master.service
## Install salt minion

## Connect salt-minion to salt-master
sudo cp /vagrant/data/etc/salt/minion /etc/salt/
sudo systemctl restart salt-minion.service