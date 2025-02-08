#!/bin/bash
    
# This shell script is for adding Wireshark's developer's PPA
# and installing latest stable version of Wireshark.
# Tested with Ubuntu 24.04.1 LTS (02/2025)


# Check ubuntu version
cat /etc/os-release

# Refresh repositories and check Wireshark installation candidate
sudo apt update && sudo apt-cache policy wireshark

# Add Wireshark PPA
sudo add-apt-repository ppa:wireshark-dev/stable

# Refresh repositories and check Wireshark installation candidate
sudo apt update && sudo apt-cache policy wireshark

# Install latest stable Wireshark
sudo apt install wireshark -y
