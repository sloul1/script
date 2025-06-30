#!/bin/bash

# Created: 2025/06/25
# Edited: 2025/06/30

# Tested on:

# Ubuntu 24.04.2 LTS (Noble Numbat) desktop

# OS: Linux Mint 22.1 (Xia)
# Kernel: Linux 6.8.0-62-generic
# Architecture: x86-64

# This script installs VSCodium including repository.

# "VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VS Code."
# "Free/Libre Open Source Software Binaries of VS Code"

# This script is created according to:
# https://vscodium.com/#install-on-debian-ubuntu-deb-package


# Add the GPG key of the repository:
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

# Add the repository:
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

# Update then install vscodium (if you want vscodium-insiders, then replace codium by codium-insiders):
sudo apt update && sudo apt install codium
