#!/bin/bash

# Script for Initializing an IoT Module development environment 
# Needs to be executed once for a machine

# Install IoT Edge Development helper
pip3 install iotedgedev

# Install yeoman (https://github.com/yeoman/yo)
sudo npm install --global yo

# Install Azure IoT Edge module template (https://github.com/Azure/generator-azure-iot-edge-module)
sudo npm install --global generator-azure-iot-edge-module

# Script for creating a common Edge Module
iotedgedev solution init --template nodejs

# Script for Build
docker build --rm -f "./modules/dht11module/Dockerfile.arm32v7.debug" -t acragri.azurecr.io/dht11module:0.0.6-arm32v7 "./modules/dht11module"
az acr login --name acragri
docker push acragri.azurecr.io/dht11module:0.0.6-arm32v7

# Command for deployment
az iot edge set-modules --hub-name agri-hub001 --device-id edge01 --content ./deployment.debug.template.json --login "<IoT Hub Connection String>"
