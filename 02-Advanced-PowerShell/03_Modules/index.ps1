<#
  How PowerShell uses Modules
#>

# Review the PS Module path environment variable
$env:PSModulePath

# Use the split operator to split the value on the semi colon to make it easier to read
$env:PSModulePath -Split ";"

# Add a custom path of C:\MyPowerShellModules to the PSModulePath environment variable
$env:PSModulePath = $env:PSModulePath + ";C:\MyPowerShellModules"

# Rerun to check the value of the variable, but note it is only valid for this session
# If PowerShell is re-launched, the custom path will no longer be in PSModulePath
$env:PSModulePath -Split ";"

# Add the custom path to the Windows Environment Variable so it is permanently available
$currentpath = [Environment]::GetEnvironmentVariable('PSModulePath','Machine')
$currentpath -Split ";"

$newpath = $currentpath + ';C:\MyPowerShellModules'
[Environment]::SetEnvironmentVariable('PSModulePath', $newpath, 'Machine')

# Rerun this to check the value of the environment variable
$currentpath = [Environment]::GetEnvironmentVariable('PSModulePath','Machine')
$currentpath -Split ";"

# List modules loaded in to this current PowerShell session
Get-Module

# List modules that are available for use on this computer 
Get-Module -ListAvailable


# Show all commands for all modules on this system
Get-Command

# Show all commands for modules that have been imported to the current session
Get-Command -ListImported

# Show all commands that belong to a specific module
Get-Command -Module BitsTransfer

# Do a get-module to see the ExportedCommands property to identify what commands are in a module
Get-Module BitsTransfer

# Same as above but call the ExportedCommands property so it formats nicely
(Get-Module BitsTransfer).ExportedCommands

# Use the verb parameter to filter commands in a module based on the verb
Get-Command -Module BitsTransfer -Verb get

# Wildcards can be used in Get-Command as well
Get-Command -Module BitsTransfer *file*



# List the commands in the PackageManagement module
Get-Command -Module PackageManagement

# List the currently registered package providers
Get-PackageProvider

# List the commands in the PowerShellGet module
Get-Command -Module PowerShellGet

# Show the registered PowerShell repositories
Get-PsRepository

# Online reference to the local repository documentation
https://docs.microsoft.com/en-us/powershell/scripting/gallery/how-to/working-with-local-psrepositories?view=powershell-7

# Create a new share on the machine and register it as a PowerShell Repository. List the repositories again
New-Item -Path C:\LocalPSRepo -ItemType Directory
New-SmbShare -Name LocalPSRepo -Path C:\LocalPSRepo
Register-PsRepository -Name LocalPSRepo -SourceLocation \\localhost\LocalPSRepo\ -ScriptSourceLocation \\localhost\LocalPSRepo\ -InstallationPolicy Trusted
Get-PsRepository

# Use Set-PsRepository to change the installation policy setting
Set-PsRepository -Name PSGallery -InstallationPolicy Trusted
Get-PSRepository
Set-PsRepository -Name PSGallery -InstallationPolicy Untrusted



# show the help for find module and run it with no parameters
Get-Help find-Module
Find-Module

# Use Find module to search for names of modules
Find-Module -Name *Slack*
Find-Module -Tag Slack

# Use Find module to get specific versions of modules
Find-Module -Name PSSlack -AllVersions
Find-Module -Name PSSlack -MaximumVersion 1.0
Find-Module -Name PSSlack -RequiredVersion 1.0.2

# Use find command to look for commands in a repository
Find-Command -ModuleName PSSlack
Find-Command -Name Get-VM

# Show the help for install module, list the PS Get version to understand the paths for scope
Get-Help Install-Module
$env:PsModulePath -Split ";"
Get-Module PowerShellGet -ListAvailable

# Install the PSSlack module, show it is installed and look at the commands in the module
Install-Module -Name PSSlack
Get-Module PSSlack -ListAvailable | fl
Get-Command -Module PSSlack


#Install a specific version of the Posh-SSH module
Install-Module -Name Posh-SSH -RequiredVersion 2.0
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Get-Module Posh-SSH -ListAvailable

# Show help for update module and use it to update to a specific version, then the latest version
Get-help update-module
Update-Module -Name Posh-SSH -RequiredVersion 2.1
Get-Module Posh-SSH -ListAvailable
Update-Module Posh-SSH

# Use get module to show the versions, import module to see that the latest is loaded by default
Get-Module Posh-SSH -ListAvailable
Import-Module Posh-SSH -Verbose

# Show the difference between installed modules and available modules
(Get-InstalledModule).count
(Get-Module -ListAvailable).count

# Show that a built in module can't be updated using PowerShellGet
Update-Module SmbShare