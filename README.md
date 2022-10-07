# gh-runner-devops-team-3

## Introduction
This repository contains the code for the GitHub Actions runner for the DevOps Team 3 using Vagrant and VirtualBox.
Two machines are created: one  provisioned with docker and the other with podman.


## Prerequisites
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Git](https://git-scm.com/downloads)

## Setup
1. Clone this repository
2. Run `vagrant up dd-runner-team31` to create the machine with docker
3. Run `vagrant up ps-runner-team31` to create the machine with podman
4. Run `vagrant ssh dd-runner-team31` to connect to the machine with docker
5. Run `vagrant ssh ps-runner-team31` to connect to the machine with podman
