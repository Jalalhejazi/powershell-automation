## Create Windows 2019 Datacenter VM on Azure


## az login  

az group create -l westeurope -n vm

$secret = "The password length must be between 12 and 123"

az vm create `
    --resource-group vm `
    --name win2019 `
    --image win2019datacenter `
    --admin-username sysadmin `
    --admin-password $secret

az vm open-port --port 3389 --resource-group vm --name win2019

