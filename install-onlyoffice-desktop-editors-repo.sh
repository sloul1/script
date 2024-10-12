#!/bin/bash

# This shell script is created according to ONLYOFFICE official documentation (2024/10).
# https://helpcenter.onlyoffice.com/installation/desktop-install-ubuntu.aspx

# Tested with Ubuntu 22.04.5 LTS.

# Add GPG key:
mkdir -p -m 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

# Add desktop editors repository:
echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list

# Update the package manager cache and install editors:
sudo apt-get update
sudo apt-get install onlyoffice-desktopeditors
