#!/bin/bash

# Install and configure Microsoft PPA
curl https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb > ./packages-microsoft-prod.deb
sudo apt install ./packages-microsoft-prod.deb
sudo apt update

# Install Moby Engine
sudo apt install moby-engine

# After installation you must add local storage to /etc/docker/daemon.json by adding the following JSON
# {
#   "log-driver": "local"
# }
# After making this change restart the service by running "sudo service docker restart" command

# Install Azure IoT Edge and Defender Micro Agent
sudo apt install aziot-edge defender-iot-micro-agent-edge

# Set Connection String for IoT Edge
sudo iotedge config mp --connection-string '<Device Connection String>'

# Apply the configuration
sudo iotedge config apply -c '/etc/aziot/config.toml'
