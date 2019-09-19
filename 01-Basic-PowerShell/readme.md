# Dag 1:  Basic PowerShell 

- https://docs.microsoft.com/en-us/powershell/


## Help and Discovery Commands

- Get-Help Get-Command 
- Get-Help about*
- Get-Help about_help
- Get-Help about_aliases
- Get-Module -ListAvailable


## Using $Variables
- Using $variables 
 

## Conditional Statements
- If
- Switch
- ForEach


## Using the Pipeline 

- Get-Service | ForEach Name
- Get-EventLog –List | Where Log –eq 'System' | ForEach Clear

## Basic Scripting

- dot sourcing (execute ps1 files)


## Setup automation and Best Practices

- [PowerShell package management and Profile](https://learning-azure.azurewebsites.net/basic-powershell/)


## Using the $Profile

- Load your own files 

