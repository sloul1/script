#!/bin/bash

## documentation starts
#
# Created 2024/04, edited 2025/01
# Tested on: Ubuntu desktop 24.04.1 LTS (Noble Numbat)  
#
# This shell script is created according to Docker's official documentation.
# https://docs.docker.com/engine/install/ubuntu/
#
# Script includes "Linux postinstall" section for managing Docker as non-root user
# https://docs.docker.com/engine/install/linux-postinstall/
#
## documentation ends

####################################################################################

# List of packages to uninstall
packages=("docker.io" "docker-compose" "docker-compose-v2" "docker-doc" "podman-docker" "containerd" "runc")

# Function to check and remove a package
remove_package() {
    local package="$1"
    
    if dpkg -l | grep -qw "$package"; then
        echo "Removing $package..."
        sudo apt-get remove --purge -y "$package"
        
        # Check if the removal was successful
        if [ $? -eq 0 ]; then
            echo "$package removed successfully."
        else
            echo "Failed to remove $package."
        fi
    else
        echo "$package is not installed."
    fi
}

# Loop through each package and attempt to remove it
for pkg in "${packages[@]}"; do
    remove_package "$pkg"
done
# Clean up any unused dependencies and update the package list
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get autoclean

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# install
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Get list of groups user belongs to
groups=$(groups)

# Linux postinstall: Check if 'docker' is in the list of groups
if echo "$groups" | grep -q -w "docker"; then
  # User is part of docker group, print confirmation message
  echo "User is a member of the 'docker' group. skipping 'Linux postinstall'."
else
  echo "User is not part of docker group, adding to group."
  sudo usermod -aG docker "$USER"

# no logging out before using "docker" command without root privileges
newgrp docker

fi
# verify installation by running hello-world
docker run hello-world