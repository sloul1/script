#!/bin/bash

# This script is created according to https://wiki.winehq.org/Ubuntu
# Script can be used also for installing and uninstalling LTspice.
# Tested on Ubuntu 22.04.03 LTS: $uname -a
# VirtualBox 6.5.0-15-generic #15~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 12 18:54:30 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

# Prompt user to choose operating system version and installation branch
echo "Choose your Ubuntu version for wine installation:"
echo "1. 20.04 Focal Fossa (Linux Mint 20.x)"
echo "2. 22.04 Jammy Jellyfish (Linux Mint 21.x)"
echo "3. 23.10 Mantic Minotaur"
echo "4. 24.04 Noble Numbat"

read -p "Enter your choice [1-4]: " version_choice

case $version_choice in
    1)
        url="focal/winehq-focal.sources";;
    2)
        url="jammy/winehq-jammy.sources";;
    3)
        url="mantic/winehq-mantic.sources";;
    4)
        url="noble/winehq-noble.sources";;
    *)
        echo "Invalid choice. Exiting."
        exit 1
esac

# Check for 64-bit system architecture and enable 32-bit architecture if not enabled
if [ $(getconf LONG_BIT) == "64" ]; then
  if ! dpkg --list | grep -q i386; then
    sudo dpkg --add-architecture i386
  fi
fi

# Add repository key
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Download the chosen Ubuntu version's Wine repository file
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/${url}

# Update repositories
sudo apt update

# Choose installation branch (stable, devel, or staging)
echo "Choose an installation branch:"
echo "1. Stable"
echo "2. Development"
echo "3. Staging"

read -p "Enter your choice [1-3]: " install_choice

case $install_choice in
    1)
        package="winehq-stable";;
    2)
        package="winehq-devel";;
    3)
        package="winehq-staging";;
    *)
        echo "Invalid choice. Exiting."
        exit 1
esac

# Install chosen package with dependencies
sudo apt install --install-recommends ${package}

# Show installed version of Wine
wineversion=$(wine --version)
echo "Installed '$wineversion'"
echo ""
# Ask if user wants to install LTspice
echo "PLEASE REMOVE ANY DOWNLOADED LTSPICE INSTALLERS IN SAME DIRECTORY YOU'RE RUNNING THIS SCRIPT."
echo "THIS SCRIPT CAN BE USED ALSO LAUNCHING UNINSTALLATION OF LTSPICE."
echo "ANSWER 'y' ON NEXT STEP EVEN IF YOU WANT TO UNINSTALL LTSPICE AS THIS LAUNCHES PROGRAM FOR UNINSTALLING."
echo ""
sleep 5
echo "Would you also like to download and install or uninstall LTspice?"
read -p "Enter 'y' for yes or any other key for no: " response

if [ "$response" = "y" ]; then
  # Download and install LTspice using Wine
  wget https://ltspice.analog.com/software/LTspice64.msi
  wine LTspice64.msi
  echo "LTspice installed."
  rm LTspice64.msi
  echo "Downloaded installation file removed."
fi
