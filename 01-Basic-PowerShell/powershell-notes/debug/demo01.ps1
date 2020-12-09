<#
  Learn how to debug PowerShell with VSCode
  - Set breakpoint with F9
  - Start Debugging with F5
  - Use F10 for step by step
#>

$serviceName = 'BITS'
$results = Get-Service -Name $serviceName

if ($results.Status -eq "running") {
    Write-Host "The Service: $serviceName is Running" -ForegroundColor green
}else {
    Write-Host "The Service: $serviceName is stopped" -ForegroundColor red
}


