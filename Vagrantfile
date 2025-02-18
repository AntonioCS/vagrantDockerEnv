# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # The base image is `ubuntu/bionic64`, i.e. Ubuntu 18.04 LTS.
  config.vm.box = "ubuntu/bionic64"

  # Install Docker.
  config.vm.provision "docker"
  
  #Name of virtualbox file
  config.vm.define "vagrantDockerEnv"

  # Run the bootstrap script.
  config.vm.provision :shell, path: "bootstrap.sh"

  # Set the guest hostname.
  config.vm.hostname = "vagrantDockerEnv"

  # Mount the dev_config/ folder we use to store stuff
  # we need to provision the machine.
  config.vm.synced_folder "dev_config/", "/dev_config/"

  # Mount the Docker certs.d folder.
  config.vm.synced_folder "docker_certs/", "/etc/docker/certs.d/", create: true
  
  #Install plugin vagrant-disksize - vagrant plugin install vagrant-disksize
  config.disksize.size = '25GB'

  # Forward ports.

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 80, host: 80
  #config.vm.network "forwarded_port", guest: 20000, host: 20000
  #config.vm.network "forwarded_port", guest: 21000, host: 21000

  #for i in 8080..8090
  #  config.vm.network :forwarded_port, guest: i, host: i
  #end

  #for i in 38000..38050
    #config.vm.network :forwarded_port, guest: i, host: i
  #end

  # Provider-specific configuration.
  config.vm.provider :virtualbox do |vm|

    # Hack (?) required to get symlinks to work in VirtualBox shared folders.
    vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/home_vagrant_code_", "1"]

    # The amount of RAM given to the VM (in MB). - 16GB
    vm.memory = "16384"
    vm.cpus = "2"
	vm.name = "vagrantDockerEnv"

	#Improve network performance - https://github.com/hashicorp/vagrant/issues/1807
	vm.customize ["modifyvm", :id, "--nictype4", "virtio"]
	#vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	#vm.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
end
