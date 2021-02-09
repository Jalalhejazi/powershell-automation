$file = "C:\dev\data_process.csv"


<################################################
    EXPORT 
################################################>

Get-Process m* | Export-Csv -Path $file

Get-Process m* |
Select-Object Name, Handle, Company, StartTime |
Export-Csv -Path $file

Get-Content $file
code $file
Invoke-Item -Path $file

Get-Process w* |
Select-Object Name, Handle, Company, StartTime |
Export-Csv -Path $file -Append

<################################################
    IMPORT 
################################################>

$data = Import-Csv -Path $file 
$data | Get-Member

$data | Select-Object * 