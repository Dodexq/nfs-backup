Vagrant.configure("2") do |config|
  
  ### For connect extra_storage "experemental"
  # shell > "VAGRANT_EXPERIMENTAL=disks vagrant up"
  # server.vm.disk :disk, size: "40GB", name: "extra_storage"
  
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ip_resolver = proc do |machine|
    result = ""
    machine.communicate.execute("ip addr show dev enp0s8") do |type, data|
      result << data if type == :stdout
    end
    (ip = /inet (\d+\.\d+\.\d+\.\d+)/.match(result)) && ip[1]
  end

  config.vm.define "nfs-server" do |server|
    server.vm.box = "geerlingguy/ubuntu2004"
    server.vm.hostname = "nfs-server"  
    server.vm.network "public_network", ip: "192.168.0.30"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.name = "nfs-server"
      vb.cpus = "2"
    end
  server.vm.provision "shell", path: "./data/nfs-provision.sh"
  end

  config.vm.define "gitlab-server" do |server|
    server.vm.box = "geerlingguy/ubuntu2004"
    server.vm.hostname = "gitlab-server"  
    server.vm.network "public_network", ip: "192.168.0.31"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.name = "gitlab-server"
      vb.cpus = "4"
    end
    server.vm.provision "shell", path: "./data/gitlab-provision.sh"
  end

  config.vm.define "prom-grafana-server" do |server|
    server.vm.box = "geerlingguy/ubuntu2004"
    server.vm.hostname = "prom-grafana-server"  
    server.vm.network "public_network", ip: "192.168.0.32"
    server.vm.provider "virtualbox" do |vb|
    
    server.vm.provision "shell",
      run: "always",
      inline: "route add default gw 192.168.0.1"

      vb.memory = "2048"
      vb.name = "prom-grafana-server"
      vb.cpus = "4"
    end
    server.vm.provision "shell", path: "./data/prom-grafana-provision.sh"
  end

  config.vm.define "salt-server" do |server|
      server.vm.box = "geerlingguy/ubuntu2004"
      server.vm.hostname = "salt-server"  
      server.vm.network "public_network", ip: "192.168.0.33"
      server.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.name = "salt-server"
        vb.cpus = "2"
      end
      server.vm.provision "shell", path: "./data/saltstack-provision.sh"
    end

end