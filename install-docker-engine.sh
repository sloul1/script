# This shell script is created according to Docker's official documentation. https://docs.docker.com/engine/install/ubuntu/                                                            

# Choose bash for command interpreter
#!/bin/bash

# remove conflicting packages
apt-get remove docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc

# Add Docker's offical GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
 apt-get update

# install
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# verify installation by running hello-world
docker run hello-world
