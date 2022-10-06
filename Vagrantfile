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

Vagrant.configure("2") do |config|
  #Iterate through node_count of Docker VM
  (1..vm_docker["node_count"]).each do |i|
    #Docker VM configuration
    config.vm.define "#{vm_docker["name"]}#{i}" do |vmconfig|
      vmconfig.vm.box = vm_docker["box"]
      vmconfig.vm.provider "virtualbox" do |vb|
        vb.memory = vm_docker["memory"]
        vb.cpus = vm_docker["cpus"]
      end

      # Install Docker
      vmconfig.vm.provision :docker
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
end
