## Create Windows 2019 Datacenter VM on Azure
## use https://shell.azure.com/powershell

# Ask user for input dependency
param (
    $groupName = "vm",
    $location  = "westeurope",
    $vmName    = "win2019"
)

# Define VM create rules
function New-AzureVM {
    az group create --location $location --name $groupName
    $secret = get-azure-secret -secretName sysadmin

    $status = az vm create          `
        --resource-group $groupName `
        --name $vmName              `
        --image win2019datacenter   `
        --admin-username sysadmin   `
        --admin-password "$secret!$secret"

    az vm open-port --port 3389 --resource-group vm --name $vmName

    echo $status
}


# Execute
New-AzureVM

