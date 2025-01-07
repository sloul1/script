#!/bin/bash

# Created 01/2025, tested on Ubuntu 24.04.1 LTS (Noble Numbat) in docker container 
# sudo docker run -ti --rm ubuntu /bin/bash

# This script is created to automate the setup of development environment on Ubuntu

# Links to developer tools that will be installed

# https://git-scm.com/
# https://docs.docker.com/engine/install/
# https://docs.docker.com/engine/install/ubuntu/
# https://nodejs.org/en/download

# Install curl
apt update && apt install curl -y

# Create symbolic linka and install 'tzdata' package 
ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime && apt-get install tzdata -y

# Install git PPA for latest upstream Git version
add-apt-repository ppa:git-core/ppa -y
apt update
apt install git -y

# Install docker engine community edition
# Remove conflicting packages
apt-get remove docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc

# Add Docker's offical GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
 apt-get update

# Install
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# verify installation by running hello-world
docker run hello-world

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