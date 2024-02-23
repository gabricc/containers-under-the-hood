Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu2204"
    config.vm.hostname = "ubuntu-22-containers"
  
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "ubuntu-22-containers"
    end
  
    config.vm.network "public_network", bridge: "en0: Wi-Fi"
    config.vm.provision "shell",  path: "provision.sh"
  end
