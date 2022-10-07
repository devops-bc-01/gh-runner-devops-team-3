# -*- mode: ruby -*-
# vi: set ft=ruby :

# Require YAML module
require "yaml"

# Read YAML file
config = YAML.load_file("provision.yml")
auth = YAML.load_file("runner.yml")

# calling list of VMs  config.yml
vms = config["vms"]
vm_docker = vms[0]
vm_podman = vms[1]

# calling environment variables from auth.yml
REPO_NAME = auth["REPO_NAME"]
BEARER_TOKEN = auth["BEARER_TOKEN"]
RUNNER_URL = auth["RUNNER_URL"]
REPO_URL = auth["REPO_URL"]

Vagrant.configure("2") do |config|
  #Iterate through node_count of Docker VM
  (1..vm_docker["node_count"]).each do |i|
    #Docker VM configuration
    config.vm.define "#{vm_docker["name"]}#{i}" do |vmconfig|
      vmconfig.vm.network "forwarded_port", guest: 9000, host: 8001, auto_correct: true
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

      # # Runner github
      # vmconfig.vm.provision "runner", type: "shell", path: "./runner/runner_script.sh", env: { "RUNNER_NAME" => "#{vm_docker["name"]}#{i}",
      #                                                                                          "BEARER_TOKEN" => "#{BEARER_TOKEN}",
      #                                                                                          "RUNNER_URL" => "#{RUNNER_URL}",
      #                                                                                          "REPO_URL" => "#{REPO_URL}" }
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
      # Runner github
      # vmconfig.vm.provision "shell", path: "./runner/runner_script.sh", env: { "RUNNER_NAME" => "#{vm_podman["name"]}#{i}",
      #                                                                          "BEARER_TOKEN" => "#{BEARER_TOKEN}",
      #                                                                          "RUNNER_URL" => "#{RUNNER_URL}",
      #                                                                          "REPO_URL" => "#{REPO_URL}" }
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
