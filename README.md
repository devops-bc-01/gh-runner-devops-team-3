# gh-runner-devops-team-3

## Introduction
This repository contains the code for the GitHub Actions runner for the DevOps Team 3 using Vagrant and VirtualBox.
Two machines are created: one  provisioned with docker and the other with podman.


## Prerequisites
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Virtualization software
- [Vagrant](https://www.vagrantup.com/downloads.html) - Virtual machine management software
- [Git](https://git-scm.com/downloads) - Version control software

## Setup
1. Clone this repository
2. Run `vagrant up ` to create the machine

## Services running 
- nexus (port 9002)
- sonarqube (port 9003)
- jenkins (port 8080)
- portainer (port 9005)

## runner.yaml
The runner.yaml file contains the configuration for the runner at github.
contains the following:

```yaml
RUNNER_URL: the url of the runner package
REPO_URL: the url of the repository where the runner will be used
BEARER_TOKEN: personal access to github token 
