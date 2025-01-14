#!/bin/bash

# Created 2025/01, tested 2025/01 on 'Ubuntu 24.04.1 LTS'

################################################################################################################

# This script is for (semi)automating installation of Cisco Packet Tracer software on Ubuntu 24.04.1 LTS.
# When installing Cisco Packet Tracer on Ubuntu 24.04.1 LTS dependencies are unmet and installer gives following error:

# 'The following packages have unmet dependencies:
# packettracer : Depends: libgl1-mesa-glx but it is not installable
# E: Unable to correct problems, you have held broken packages.'

# This script resolves this issue.

# Packages installed by this script can be uninstalled:
# sudo apt remove packettracer libgl1-mesa-glx -y

##################################################################################################################
# Pre-requisites:
#
# 1. First you have to register and download Cisco Packet Tracer software installer for Ubuntu.
# https://www.netacad.com/resources/lab-downloads?courseLang=en-US 
#
# 2. Check that downloaded Cisco installer has same name as in script (# 4.5) 
# 'Packet_Tracer822_amd64_signed.deb'
##################################################################################################################

# 3. Run this script in same directory with installation package.

# 4.1 Update software repositories
sudo apt update

# 4.2 Check if curl is installed and install it only if it is not installed
if ! command -v curl &> /dev/null; then
    sudo apt install curl -y
fi

# 4.3 Download dependency
curl -O https://archive.ubuntu.com/ubuntu/pool/universe/m/mesa/libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb

# 4.4 Install dependency
sudo apt install ./libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb -y

# 4.5 Install Cisco Packet Tracer
sudo apt install ./Packet_Tracer822_amd64_signed.deb -y
