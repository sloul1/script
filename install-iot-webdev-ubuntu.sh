#!/bin/bash

# Created 01/2025 

# This script is created to automate the setup of development environment install on Ubuntu 
# according to the official documentation of: Git, Docker and NodeJS.

# https://git-scm.com/
# https://docs.docker.com/engine/install/
# https://docs.docker.com/engine/install/ubuntu/
# https://nodejs.org/en/download

# Tested natively on Ubuntu 24.04.1 LTS (Noble Numbat) OS,
# on Ubuntu 24.04.1 LTS (Noble Numbat) Docker container
# and in Windows 11 using WSL and Ubuntu 24.04.1 LTS.

# Script installs: curl, tzdata, git, docker engine community edition, nvm, node  

# Running script on Ubuntu 24.04.1 LTS (Noble Numbat) in docker container

# Pre-requisites: post installation steps to run docker without 'sudo' in front of 'docker' command
# https://docs.docker.com/engine/install/linux-postinstall/

# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker run hello-world

# docker run -ti --rm ubuntu /bin/bash
# apt update && apt install curl -y
# curl https://raw.githubusercontent.com/sloul1/script/refs/heads/main/install-iot-webdev-ubuntu.sh | bash -x

# Running script on native Ubuntu 24.04.1 LTS
# or on Windows 11 using WSL and Ubuntu 24.04.1 LTS

# sudo apt update && sudo apt upgrade
# sudo apt install curl -y
# curl -O https://raw.githubusercontent.com/sloul1/script/refs/heads/main/install-iot-webdev-ubuntu.sh
# chmod +x install-iot-webdev-ubuntu.sh
# ./install-iot-webdev-ubuntu.sh

# Install curl
sudo apt update && apt install curl -y

# Create symbolic linka and install 'tzdata' package 
ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime && apt-get install tzdata -y

# Install git PPA for latest upstream Git version
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y

# Install docker engine community edition
# Remove conflicting packages
sudo apt-get remove -y docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc

# Add Docker's offical GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# verify installation by running hello-world
# docker run hello-world

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

. ~/.bashrc
echo $NVM_DIR

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
##node -v # Should print "v22.12.0".
##nvm current # Should print "v22.12.0".

# Verify npm version:
##npm -v # Should print "10.9.0".

GIT_VERSION=$(git -v)
DOCKER_VERSION=$(docker -v)
DOCKER_COMPOSE_VERSION=$(docker compose version)
NODE_VERSION=$(node -v)
NPM_VERSION=$(npm -v)

echo -e "Current git version: \033[1;33m$GIT_VERSION\033[0m"
echo -e "Current docker version: \033[1;33m$DOCKER_VERSION\033[0m"
echo -e "Current docker compose version: \033[1;33m$DOCKER_COMPOSE_VERSION\033[0m"
echo -e "Current NodeJS version: \033[1;33m$NODE_VERSION\033[0m"
echo -e "Current NPM version: \033[1;33m$NPM_VERSION\033[0m"
