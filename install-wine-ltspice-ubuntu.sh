#!/bin/bash

# This script is created according to https://wiki.winehq.org/Ubuntu documentation.
# Script can be also used for installing LTspice.

# Tested on Ubuntu 22.04.03 LTS VM and Ubuntu 22.04.4 LTS laptop: $uname -a
# VirtualBox 6.5.0-15-generic #15~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 12 18:54:30 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
# Linux xxxxxx-xxxxxx 6.8.0-40-generic #40~22.04.3-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 30 17:30:19 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

# Clear screen
clear
# Enter to forward
fwd(){
    stty sane
    read -r -p "Press enter to continue... " dummy_input
    echo ""
}

# Error message
error(){
    echo -ne "\033[31mERROR:\033[0m Invalid choice. Exiting.\n"
    exit 1
}

# Prompt user to choose operating system version and installation branch
echo "This script is created according to https://wiki.winehq.org/Ubuntu documentation"
echo "This script installs wine and optionally LTspice."
echo "Please follow script instructions carefully."

fwd

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

        error
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
echo ""
echo -ne "\033[32mWine repository added.\033[0m"
echo ""
fwd
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
        error
esac

# Install chosen package with dependencies
sudo apt install --install-recommends ${package}

# Show installed version of Wine
wineversion=$(wine --version)
echo -ne "\033[32mINSTALLED '$wineversion'\033[0m\n"
fwd
# Ask if user wants to install LTspice
echo -ne "\033[31mPlease REMOVE ANY DOWNLOADED LTSPICE INSTALLERS IN THIS DIRECTORY before proceeding with LTspice installation.\033[0m\n"
fwd
echo "Would you also like to download and install LTspice?"
echo -ne "\033[31mNote that LTspice installation window may not keep on the top during installation.\033[0m\n"
# Look into keeping installation window on top during installation.

read -p "Enter 'y' for yes or any other key for no: " response

# Download and install LTspice using Wine
if [ "$response" = "y" ]; then

  wget https://ltspice.analog.com/software/LTspice64.msi
  wine msiexec /i LTspice64.msi
  echo -ne "\033[32mLTspice installed.\033[0m\n"
  rm LTspice64.msi
  echo "Downloaded installation file removed."
  echo -ne "\033[32mUse mouse right click on 'LTspice.desktop' icon on your desktop and choose 'Allow launching' to make link executable.\033[0m\n"
# Look further into uninstallation.
fi
