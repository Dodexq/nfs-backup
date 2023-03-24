sudo apt update
sudo apt upgrade -y
sudo apt install net-tools -y
## Install prometheus
wget -P /tmp https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz
tar xvf /tmp/prometheus-2.37.0.linux-amd64.tar.gz -C /tmp
cd /tmp/prometheus-2.37.0.linux-amd64 && sudo mv prometheus /usr/bin/ && sudo mv promtool /usr/bin/
sudo mkdir /etc/prometheus && sudo mv console /etc/prometheus/ && sudo mv console_libraries /etc/prometheus/
sudo cp prometheus.yml /etc/prometheus && sudo cp /vagrant/data/etc/systemd/system/prometheus.service /etc/systemd/system/
sudo systemctl start prometheus.service && sudo systemctl enable prometheus.service
## Install Grafana
sudo apt-get install apt-transport-https -y
sudo apt-get install software-properties-common -y
sudo wget -q -O /usr/share/keyrings/grafana.key https://packages.grafana.com/gpg.key
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install grafana-enterprise -y
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
## Add default router
sudo route add default gw 192.168.0.1