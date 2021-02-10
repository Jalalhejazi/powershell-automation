function my-random-generator {
    return -join ((48..57) + (97..122) | Get-Random -Count 6 | % {[char]$_})
}

function deploy-webapp-snippets {

    param(
        $resourceGroup      = "demo-2021",
        $location           = "westeurope",
        $appName            = "webapp-2021",
        $sqlServerName      = "sqlserver",
        $databaseName       = "SnippetsDatabase",
        $sqlServerUsername  = "sysadmin",
        $sqlServerPassword  
    )

    # easy solution to generate uniqueStrings
    $g = my-random-generator

    $resourceGroup      = "$resourceGroup-$g"
    $appName            = "$appName-$g"
    $sqlServerName      = "$sqlServerName-$g"
    
    # create a resource group
    az group create -n $resourceGroup -l $location

    # create the app service plan
    $planName="hardware-$location-$appname"
    az appservice plan create -n $planName -g $resourceGroup --sku B1

    # create the webapp
    az webapp create -n $appName -g $resourceGroup --plan $planName

    # Configure git deployment
    $gitrepo="https://superusers-kursus@dev.azure.com/superusers-kursus/Webapp-snippets/_git/Webapp-snippets"


    # configure the app to deploy from $gitrepo
    az webapp deployment source config -n $appName -g $resourceGroup --repo-url $gitrepo --branch master --manual-integration

    # create the SQL server
    az sql server create -n $sqlServerName -g $resourceGroup -l $location -u $sqlServerUsername --admin-password $sqlServerPassword


    # create the database
    az sql db create -g $resourceGroup -s $sqlServerName -n $databaseName --service-objective Basic
    
    # allow IP address to access SQL server Firewall
    az sql server firewall-rule create -g $resourceGroup -s $sqlServerName -n AllowWebApp1 --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0


    ## Web app configuration "connection to SQLAzure" 
    
    # construct the connection string
    $connectionString="Server=tcp:$sqlServerName.database.windows.net;Initial Catalog=$databaseName;User ID=$sqlServerUsername@$sqlServerName;Password=$sqlServerPassword;Trusted_Connection=False;Encrypt=True;"

    # provide add the connection string to the web app
    az webapp config connection-string set -n $appName -g $resourceGroup -t SQLAzure --settings "SQLSERVER=$connectionString"

    # To migrate/setup the database model to SQLServer
    # Browse to "https://$site/migrate"

}


deploy-webapp-snippets -sqlServerPassword $sa_password

