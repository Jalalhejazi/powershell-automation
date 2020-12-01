## Create Windows 2019 Datacenter VM on Azure


## az login  

az group create -l westeurope -n vm

az vm create `
    --resource-group vm `
    --name win2019 `
    --image win2019datacenter `
    --admin-username sysadmin `
    --admin-password 'todo change pwd here'

az vm open-port --port 3389 --resource-group vm --name win2019

