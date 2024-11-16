#!/bin/bash

# This installer script is created according to WINE documentation https://gitlab.winehq.org/wine/wine/-/wikis/Debian-Ubuntu
# Installation command for stable branch in the WINE documentation is not working¨ (sudo apt install --install-recommends winehq-stable).
# At the time this script is created (Nov 2024) working install command is: sudo apt install --install-recommends wine-stable
# This modification is included in this script.
# Created and tested November 16. 2024 with Ubuntu 24.04.1 LTS.

# This script should be run as super user: sudo ./install-wine-ubuntu.sh


#Enable 32 bit architecture in 64 bit system
dpkg --add-architecture i386

#Query Ubuntu distribution code name and save result to CODENAME variable.
CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d '=' -f2-)

#Download and add repository key
mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

#Add the repository
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/${CODENAME}/winehq-${CODENAME}.sources

#Update package information
apt update

#Install WINE stable branch
apt install --install-recommends wine-stable
