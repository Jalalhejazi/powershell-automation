
# Windows PowerShell (5.1 legacy) vs. PowerShell (7.1 Cloud)

- ~~Windows powershell~~  (Latest version 5.x)
- PowerShell          (Cloud optimized) === (Linux og Windows)

Create $profile for first time
```powershell
New-Item -Path $PROFILE -ItemType File -Force
```

## PowerShell Editor

- https://code.visualstudio.com/download


```powershell
code $profile
```




## Download Help files

Download and installs the newest help files on your computer.

- [Update-help online ](https://docs.microsoft.com/da-dk/powershell/module/Microsoft.PowerShell.Core/Update-Help?view=powershell-5.1)

start powershell as admin user:
- Update-Help -ErrorAction Ignore 
- Update-Help -ErrorAction Ignore -UICulture en-US



## Get Help 
- Get-Help about_* 

```powershell

Get-Help about_* | out-file c:\dev\powershell_help.txt

```


- Get-Help about_*  > ./powershell_help.txt
- Get-Help about_Profiles
- Get-Help about_Aliases
- Get-Help about_help
- Get-Module -ListAvailable


## Contents
- [Overview](overview.md)
- [Variables, Operators, TypeCasting](building_blocks.md)
- [Read Validate and Write](read_validate.md)
- [Comparison Operators](comparison.md)
- [If else and Switch](conditional.md)
- [Collections](collections.md)
- [Loops](loops.md)
- [Functions](functions.md)
- [Processes and Services](process_and_service.md)
- [Debugging](debug/demo01.ps1)


## References
- [Microsoft PowerShell Resource](https://docs.microsoft.com/en-us/powershell)
- [CheatSheet](https://ss64.com/ps/)


