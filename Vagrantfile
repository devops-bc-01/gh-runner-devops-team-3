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
# Number of VMs
node_count = config["node_count"]

Vagrant.configure("2") do |config|
  #Docker VM configuration
  config.vm.define vm_docker["name"] do |vmconfig|
    vmconfig.vm.box = vm_docker["box"]
    vmconfig.vm.provider "virtualbox" do |vb|
      vb.memory = vm_docker["memory"]
      vb.cpus = vm_docker["cpus"]
    end
  end

  #Podman VM configuration to other VMs (nodes)
  #Iterate through node_count
  (1..node_count).each do |i|
    config.vm.define "#{vm_podman["name"]}#{i}" do |vmconfig|
      vmconfig.vm.box = vm_podman["box"]
      vmconfig.vm.provider "virtualbox" do |vb|
        vb.memory = vm_podman["memory"]
        vb.cpus = vm_podman["cpus"]
      end
    end
  end
end
