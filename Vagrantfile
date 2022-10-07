# -*- mode: ruby -*-
# vi: set ft=ruby :

# Require YAML module
require "yaml"

# Read YAML file
config = YAML.load_file("config.yml")

# calling list of VMs
vms = config["vms"]
vm_docker = vms[0]
vm_podman = vms[1]

# docker compose YAML file
#docker_compose = YAML.load_file("docker-compose.yaml")
#docker-compose up -d
#services = docker_compose["services"]

Vagrant.configure("2") do |config|

  #Iterate through node_count of Docker VM
  (1..vm_docker["node_count"]).each do |i|
    #Docker VM configuration
    config.vm.define "#{vm_docker["name"]}#{i}" do |vmconfig|
      config.vm.network "forwarded_port", guest: 8080, host: 9001, auto_correct: true
      config.vm.network "forwarded_port", guest: 8081, host: 8081, auto_correct: true
      config.vm.network "forwarded_port", guest: 9000, host: 9003, auto_correct: true
      vmconfig.vm.box = vm_docker["box"]
      vmconfig.vm.provider "virtualbox" do |vb|
        vb.memory = vm_docker["memory"]
        vb.cpus = vm_docker["cpus"]
      end

      # Install Docker
      vmconfig.vm.provision :docker

      # Install Docker Compose plugin
      plugin_name = "vagrant-docker-compose"
      if !Vagrant.has_plugin?(plugin_name)
        system("vagrant plugin install #{plugin_name}")
      end

      # Install Docker compose and YAML modul
      # Env method to read .env file
      vmconfig.vm.provision :docker_compose

      # Run file docker-compose.yaml
      vmconfig.vm.provision "shell", inline: "cd /vagrant && docker compose up -d", privileged: false
    end
  end

  #Iterate through node_count of Podman VM
  (1..vm_podman["node_count"]).each do |i|
    #Podman VM configuration
    config.vm.define "#{vm_podman["name"]}#{i}" do |vmconfig|
      vmconfig.vm.box = vm_podman["box"]
      vmconfig.vm.provider "virtualbox" do |vb|
        vb.memory = vm_podman["memory"]
        vb.cpus = vm_podman["cpus"]
      end
      # Install Podman
      vmconfig.vm.provision "podman", type: "shell", inline: <<-SHELL
        sudo apt-get install -y podman
      SHELL
    end
  end

  # Provisioning fish shell for all VMs
  config.vm.provision "shell", type: "shell", inline: <<-SHELL
    # Fish exists?
    if ! command -v fish > /dev/null; then
        # Install fish
        sudo apt-add-repository ppa:fish-shell/release-3
        sudo apt-get install fish -y
        #Set fish as def2
        sudo chsh -s /usr/bin/fish vagrant
    fi
    echo "Fish shell installed"
  SHELL
end
