#!/bin/bash

# Source the .env file
if [ -f ".env" ]; then
    source .env
else
    echo "Error: .env file not found."
    exit 1
fi

# Create a resource group
echo "Creating resource group $AZURE_RESOURCE_GROUP in $AZURE_LOCATION"
az group create --name $AZURE_RESOURCE_GROUP --location $AZURE_LOCATION
sleep 5
# Create a storage account
echo "Creating storage account $AZURE_STORAGE_ACCOUNT in $AZURE_LOCATION"
az storage account create --name $AZURE_STORAGE_ACCOUNT --location $AZURE_LOCATION --resource-group $AZURE_RESOURCE_GROUP --sku Standard_LRS --allow-blob-public-access false
sleep 5
# Create a function app
echo "Creating function app $AZURE_FUNCTION_APP in $AZURE_LOCATION"
az functionapp create --resource-group $AZURE_RESOURCE_GROUP --consumption-plan-location $AZURE_LOCATION --runtime node --runtime-version 20 --functions-version 4 --name $AZURE_FUNCTION_APP --storage-account $AZURE_STORAGE_ACCOUNT
sleep 5
# Configure the function app settings
echo "Configuring function app settings"
az functionapp config appsettings set --name $AZURE_FUNCTION_APP --resource-group $AZURE_RESOURCE_GROUP --settings \
    SLACK_BOT_TOKEN="$SLACK_BOT_TOKEN" \
    SLACK_CHANNEL_ID="$SLACK_CHANNEL_ID" \
    SLACK_MESSAGE="$SLACK_MESSAGE"