## It works on my machine

## Step 01 
## Dependency Management
## get-azure-secret --> Azure KeyVault 


$connectTestResult = Test-NetConnection -ComputerName superusers2020.file.core.windows.net -Port 445  
$secret = get-azure-secret -secretName storage-key

if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"superusers2020.file.core.windows.net`" /user:`"Azure\superusers2020`" /pass:`"$secret`""
    # Mount the drive
    New-PSDrive -Name K -PSProvider FileSystem -Root "\\superusers2020.file.core.windows.net\kursus" -Persist -ErrorAction SilentlyContinue
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}


