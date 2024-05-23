#!/bin/bash

# Shell script for building and running open-webui with Nvidia GPU acceleration. https://docs.openwebui.com/getting-started/#docker-compose 
# Clone open-webui with: $ git clone https://github.com/open-webui/open-webui.git
# ...cd into open-webui and place rungpu.sh in open-webui directory.
# Make script executable: $ chmod +x rungpu.sh
# ...and run it: ./rungpu.sh

docker compose -f docker-compose.yaml -f docker-compose.gpu.yaml up -d --build
