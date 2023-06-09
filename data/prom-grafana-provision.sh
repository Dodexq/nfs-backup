sudo apt update
sudo apt upgrade -y
sudo apt install net-tools -y
## Install prometheus
wget -P /tmp https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz
tar xvf /tmp/prometheus-2.37.0.linux-amd64.tar.gz -C /tmp
cd /tmp/prometheus-2.37.0.linux-amd64 && sudo mv prometheus /usr/bin/ && sudo mv promtool /usr/bin/
sudo mkdir /etc/prometheus && sudo mv consoles /etc/prometheus/ && sudo mv console_libraries /etc/prometheus/
sudo cp prometheus.yml /etc/prometheus && sudo cp /vagrant/data/etc/systemd/system/prometheus.service /etc/systemd/system/
sudo systemctl start prometheus.service && sudo systemctl enable prometheus.service
## Connect Prometheus to node-exporter
sudo cp /vagrant/data/etc/prometheus/prometheus.yml /etc/prometheus/
sudo systemctl restart prometheus.service
## Install Alert-manager
wget -P /tmp https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-amd64.tar.gz
tar xvf /tmp/alertmanager-0.25.0.linux-amd64.tar.gz -C /tmp
cd /tmp/alertmanager-0.25.0.linux-amd64 && sudo mv alertmanager /usr/bin/ && sudo mv amtool /usr/bin/
sudo mkdir /etc/alertmanager
sudo cp alertmanager.yml /etc/alertmanager && sudo cp /vagrant/data/etc/systemd/system/alertmanager.service /etc/systemd/system/
sudo systemctl start alertmanager.service && sudo systemctl enable alertmanager.service
## Install Grafana
sudo apt-get install apt-transport-https -y
sudo apt-get install software-properties-common -y
sudo wget -q -O /usr/share/keyrings/grafana.key https://packages.grafana.com/gpg.key
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install grafana-enterprise -y
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
## Install salt minion
sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3004 focal main" | sudo tee /etc/apt/sources.list.d/salt.list
sudo apt update
sudo apt-get install salt-minion -y
## Connect salt-minion to salt-master
sudo cp /vagrant/data/etc/salt/minion /etc/salt/
sudo systemctl restart salt-minion.service
## Install Docker && Docker-compose
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin