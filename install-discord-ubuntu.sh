#!/usr/bin/bash

# Function to print success message
function print_success {
    local message="$1"
    echo -e "\033[0;32m$1\033[0m" # Green color for success
}


# Download latest Discord package for Debian based Linux
function dl_packet {
echo -e "\033[0;33mDownloading latest Discord package for Debian based Linux\033[0m"
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
}

dl_packet

DISCORD_PACKAGE=discord.deb

if [ ! -f "$DISCORD_PACKAGE" ]; then
    echo -e "\033[0;31mDiscord package not downloaded. Please download it before installing.\033[0m"
    exit 1
fi

# Attempt to install the Discord package using dpkg
sudo dpkg -i "$DISCORD_PACKAGE"

if [ $? -eq 0 ]; then
    print_success "Installation complete."
else
    # If there was an error, attempt to fix broken dependencies with apt-get
    sudo apt-get install -f
    
    if [ $? -eq 0 ]; then
        print_success "Installation complete after fixing dependencies."
    else
        echo -e "\033[0;31mInstallation failed. Please check for errors and try again.\033[0m"
    fi
fi

# Check if the user wants to delete the package file
if [[ "$1" == "--delete" ]]; then
    if [ -f "discord.deb" ]; then
        rm "discord.deb"
        echo -e "\033[0;32mDiscord package deleted.\033[0m"
    else
        echo -e "\033[0;31mDiscord package not found. Cannot delete.\033[0m"
    fi
    exit 0
fi

# Optionally, prompt the user to delete the package file
read -p "Do you want to delete the downloaded Discord package? (y/n): " answer
if [[ $answer == [Yy] ]]; then
    if [ -f "$DISCORD_PACKAGE" ]; then
        rm "$DISCORD_PACKAGE"
        echo -e "\033[0;32mDiscord package deleted.\033[0m"
    else
        echo -e "\033[0;31mDiscord package not found. Cannot delete.\033[0m"
    fi
fi