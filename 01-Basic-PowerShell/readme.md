# Dag 1:  Basic PowerShell 

- https://docs.microsoft.com/en-us/powershell/


## Download Help files

Download and installs the newest help files on your computer.

- [Update-help online ](https://docs.microsoft.com/da-dk/powershell/module/Microsoft.PowerShell.Core/Update-Help?view=powershell-5.1)

start powershell as admin user:
- Update-Help -ErrorAction Ignore 


## Get Help 
- Get-Help about_* 
- Get-Help about_*  > ./powershell_help.txt
- Get-Help about_PowerShell.exe 
- Get-Help about_help
- Get-Help about_Aliases
- Get-Module -ListAvailable


## Using $Variables
- Get-Help about_Variables
 

## Conditional Statements
- Get-Help about_If 
- Get-Help about_Switch
- Get-Help about_Foreach


## Using the Pipeline 

- Get-Help about_Pipelines
- Get-Service | ForEach Name
- Get-EventLog –List | Where Log –eq 'System'


## Using Function for ReUseAbility (DRY)

- Get-Help about_Functions


## Basic Scripting

- dot sourcing (execute ps1 files)

## Using the $Profile
- What can you do with $profile?
- Use others profile to get inspirations 


## PowerShell as a Team

- [How to share your scripts with your team](https://learning-azure.azurewebsites.net/basic-powershell/)


