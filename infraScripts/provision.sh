#!/bin/bash

# Add IoT extension if not present
az extension add --name azure-iot

# Create resource group
az group create --name agri-iot --location centralindia

# Create a standard IoT Hub
az iot hub create --resource-group agri-iot --name agri-hub001 --sku S1 --location centralindia

# Provision device
az iot hub device-identity create --hub-name agri-hub001 --device-id edge01 --edge-enabled

# List registered devices and their status
az iot hub device-identity list --hub-name agri-hub001 --output table

# Retrieve Connection String
az iot hub device-identity connection-string show --device-id edge01 --hub-name agri-hub001

# Create Container Registry
az acr create --name acragri --location centralindia --resource-group agri-iot --sku Basic --admin-enabled true 
