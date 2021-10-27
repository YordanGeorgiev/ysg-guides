https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
### install az on mac 
brew update && brew install azure-cli


### login to the vaultit serivces , open the broser and use your AD credentials
az login

### how-to install aks 
sudo az aks install-cli


### list my accounts 
az account list|jq -r '.[]|.name'

### set my account subscription to vault-it alpha
az account set --subscription vaultit-alpha


### list my resource groups
az group list | jq -r '.[]|.name'|sort

### how-to setup my kubectl , ops DISPLAY needed to confirm in browser
az aks get-credentials --resource-group rg-kubernetes-alpha --name aks-vaultit01-alpha


### how-to list the my kevaults 
az resource list| jq -r '.[]|select (.type | contains ("Microsoft.KeyVault/vaults"))| .name '|sort

### how-to list my private end points 
az resource list| jq -r '.[]|select (.type | contains ("Microsoft.Network/privateEndpoints"))| .name '|sort

### how-to list the db servers
az resource list| jq -r '.[]|select (.type | contains ("Microsoft.DBforPostgreSQL/servers"))| .name '|sort




az aks get-credentials --resource-group rg-id-alpha --name aks-vaultit01-alpha

