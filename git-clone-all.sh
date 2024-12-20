#!/bin/bash

# This script clones all github.com repositories from a specified user.
# Based on: https://gist.github.com/vke-code/fda27b3ae617e733f3d28e939caee22f
# Tested on Ubuntu 24.04.1 LTS desktop.

echo -e "Please enter GitHub username and press enter for full clone of user's repositories:\n(or Ctrl + C to exit)"
read USER

# clone all repositories for specified user:
for repo in `curl -s https://api.github.com/users/$USER/repos?per_page=1000 |grep clone_url |awk '{print $2}'| sed 's/"\(.*\)",/\1/'`;do
git clone $repo;
done;