Vagrant.configure("2") do |config|
  
  config.hostmanager.enabled = true 
  config.hostmanager.manage_host = true
  config.vm.boot_timeout = 900

  config.vm.define "nfs-server" do |server|
    server.vm.box = "geerlingguy/ubuntu2004"
    server.vm.hostname = "nfs-server"  
    server.vm.network "public_network", ip: "192.168.0.30"
  # shell > "VAGRANT_EXPERIMENTAL=disks vagrant up"
    #server.vm.disk :disk, size: "40GB", name: "extra_storage"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "nfs-server"
      vb.cpus = "4"
    end
  server.vm.provision "shell", path: "./data/nfs-provision.sh"
  end

  config.vm.define "gitlab-server" do |server|
    server.vm.box = "geerlingguy/ubuntu2004"
    server.vm.hostname = "gitlab-server"  
    server.vm.network "public_network", ip: "192.168.0.31"
  # shell > "VAGRANT_EXPERIMENTAL=disks vagrant up"
    #server.vm.disk :disk, size: "40GB", name: "extra_storage"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "gitlab-server"
      vb.cpus = "4"
    end
    server.vm.provision "shell", path: "./data/gitlab-provision.sh"
  end

end