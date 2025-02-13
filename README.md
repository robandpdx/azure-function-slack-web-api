# azure-function-slack-web-api

## Create supporting azure resources for the function
1. Login to azure
```
az login
```
2. Copy the `.env-sample` file to `.env` and edit as needed
3. Run the `scripts/create-azure-resources.sh` script

## Deploy the function
```
func azure functionapp publish $AZURE_FUNCTION_APP
```

## Tets the function locally
Get the $AZURE_STORAGE_ACCOUNT connection string and set it as the value of `AzureWebJobsStorage` in the `local.settings.json` file.  
Start the vscode debugger `Attach to Node Functions`.  

Hit the local URL with your web browser.  