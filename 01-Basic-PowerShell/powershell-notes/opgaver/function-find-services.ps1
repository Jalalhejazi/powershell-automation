#  function som finder en eller flere services

function find-service {
    param (
        $serviceName
    )
    Get-Service -Name $serviceName
}

find-service -serviceName 