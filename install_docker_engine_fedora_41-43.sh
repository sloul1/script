#!/bin/bash

## documentation starts
#
# Created 2025/11
# Tested on: Fedora Linux 42 (Workstation Edition)  
#
# This shell script is created according to Docker's official documentation.
# https://docs.docker.com/engine/install/fedora/
#
# Script includes "Linux postinstall" section for managing Docker as non-root user
# https://docs.docker.com/engine/install/linux-postinstall/
#
## documentation ends

####################################################################################

# List of packages to uninstall
packages=(docker
    docker-client
    docker-client-latest
    docker-common
    docker-latest
    docker-latest-logrotate
    docker-logrotate
    docker-selinux
    docker-engine-selinux
    docker-engine)

# Function to check and remove a package
remove_package() {
    local package="$1"
    if rpm -q "$package" &>/dev/null; then
        echo "Removing $package..."
        sudo dnf remove -y "$package"
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
sudo dnf autoremove -y

## Add Docker's official GPG key:
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

## install
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Start Docker Engine
sudo systemctl enable --now docker

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