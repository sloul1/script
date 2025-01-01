# install-github-assets.sh

This script is part of an endeavor for setting up software development environment automatically on Android devices.

As an individual who is constantly on the move I'm contributing to my well being and physical ergonomics by carrying lighter devices with me. 

At this point I feel using [Code-Server](https://github.com/coder/code-server?tab=readme-ov-file) with [Termux](https://github.com/termux/termux-app) locally on Android device aren't my favourite tools for developing considering cognitive ergonomics. Regardless of this at my current situation as an **unemployed software developer** and **ITC engineering student** whose **study loan capital keeps increasing** this is great opportunity to learn new skills for developing with no cost.

Created in 2025/01 on Android 14 using Termux and
Code-Server using "tur-repo" install option. 
https://coder.com/docs/code-server/termux  

Tested on:
 - Android 14 (Linux localhost 4.19.191+ #1 SMP PREEMPT Wed Nov 27 23:47:52 CST 2024 aarch64 Android)
 - Ubuntu 24.04.1 LTS (Linux 6.8.0-51-generic x86_64) 

This bash script is created to download latest version of Termux from GitHub repository. It lists available apk-files for latest version of Termux and uses interaction for choosing what file to download from list.

> [!NOTE]
> Use 'sudo ./install-github-assets.sh' for installing dependencies with elevated user permissions if needed.

Script needs 'jq' to operate and calls external 'install-dependencies.sh' file for checking if 'jq' is installed. As default 'install-dependenies.sh' needs to be in same directory with this script. Dependency installation file path can be configured as absolute or relative source. 'apt' is used for installation if needed.
  
 https://github.com/jqlang/jq
 "...a lightweight and flexible command-line JSON processor akin to sed,awk,grep..."
