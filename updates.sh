#!/bin/bash

# Simple script for updating software using different package management
# systems. Uncomment to fit your purpose.

# update aptitude repositories and upgrade installed software
sudo apt update && sudo apt upgrade -y

# kill snap-store for refreshing
#sudo killall snap-store

# update software installed through snap
#sudo snap refresh

# update software installed through flatpak
#sudo flatpak update
