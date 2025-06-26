#!/bin/bash

# Updated 2025/06 to list all files in chosen repo instead of only with .apk extension.

# This bash script was originally created to download latest version of Termux from GitHub repository.
# Updated version lists all files of given user and repository.
# There is user interaction for choosing file to download from list.

# Created in 2025/01 on Android 14 using Termux and
# Code-Server using "tur-repo" install option.
# https://coder.com/docs/code-server/termux

# Tested on:
# - 2025/01 Android 14 (Linux localhost 4.19.191+ #1 SMP PREEMPT Wed Nov 27 23:47:52 CST 2024 aarch64 Android)
# - 2025/01 Ubuntu 24.04.1 LTS (Linux 6.8.0-51-generic x86_64)
# - 2025/06 Ubuntu 24.04.2 LTS (Linux 6.11.0-26-generic x86_64)

# Use 'sudo ./install-github-assets.sh' for installing with elevated user permissions if needed.

# Script needs 'jq' to operate and calls external 'install-dependencies.sh' file for checking if 'jq' is installed.
# As default 'install-dependenies.sh' needs to be in same directory with tthis script. There is also some option below
# for configurig 'absolute file path' if needed.
# 'apt' is used for installation if needed.

# https://github.com/jqlang/jq
# "...a lightweight and flexible command-line JSON processor akin to sed,awk,grep..."

# Define dendency installation file source.
# source /path/to/your/script/jq_install.sh  # Absolute file path
source ./install-dependencies.sh             # Relative file path (same directory)

# Uncomment two lines below if you want to enable user input interaction for GitHub username and repository variables
# read -p "Enter your GitHub username: " GH_USERNAME
# read -p "Enter your GitHub repository name: " GH_REPO

# Hardcoded values for variables
# Comment out with '#' two lines below if you want to use user input interaction above
GH_USERNAME="gohugoio"
GH_REPO="hugo"

LATEST_TAG=$(curl -sL https://api.github.com/repos/$GH_USERNAME/$GH_REPO/releases/latest | jq -r '.tag_name')
echo "Latest release of $GH_USERNAME/$GH_REPO is $LATEST_TAG."

LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$GH_USERNAME/$GH_REPO/releases/tags/$LATEST_TAG")

APKS=()
SIZES=()
while IFS=$'\t' read -r url size; do
  FILENAME=$(basename "$url")
  APKS+=("$FILENAME")
  SIZES+=($((size / (1024 * 1024))))
done < <(echo "$LATEST_RELEASE" | jq -r '.assets[] | .browser_download_url + "\t" + (.size|tostring)')

for i in "${!APKS[@]}"; do
  echo "$((i+1)). ${APKS[$i]}, Size: ${SIZES[$i]} MB"
done

read -p "Enter your choice: " CHOICE

if [[ $CHOICE =~ ^[0-9]+$ ]] && [ $CHOICE -gt 0 ] && [ $CHOICE -le ${#APKS[@]} ]; then
  DECODED_URL=$(printf '%b' "${APKS[$((CHOICE-1))]//%/\\x}")
  curl -LO "https://github.com/$GH_USERNAME/$GH_REPO/releases/download/$LATEST_TAG/$DECODED_URL"
else
  echo "Invalid choice. Please enter a number between 1 and ${#APKS[@]}."
fi
