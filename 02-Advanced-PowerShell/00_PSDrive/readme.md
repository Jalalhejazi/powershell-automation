## About PSDrive

```powershell 

get-command -noun psdrive

Get-PSDrive
Get-PSProvider

ls alias:
ls c:
ls env:

cd c:
cd alias:
cd env:
```


## How to create PSDrive to mount to remote DISK ? 

```powershell 

help New-PSDrive -online
help New-PSDrive -examples


$config = @{
    Name = "MyDocs"
    PSProvider = "FileSystem"
    Root = "C:\Users\User01\Documents"
    Description = "Maps to my My Documents folder."
}
New-PSDrive @config



$connectTestResult = Test-NetConnection -ComputerName superusers2020.file.core.windows.net -Port 445

if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"superusers2020.file.core.windows.net`" /user:`"Azure\superusers2020`" /pass:`"******************`""
    # Mount the drive
    New-PSDrive -Name K -PSProvider FileSystem -Root "\\superusers2020.file.core.windows.net\kursus" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}


```