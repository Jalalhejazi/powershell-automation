## Connect to a KBG Exchange Server
[CmdletBinding()]
Param(
	[parameter()]
    [ValidateSet( 2016, 2019)]
	[Int]$Edition = 2019
)

Switch ($Edition) 
{
	2016  {$Server =  'KBG-EXCH-2' }
	2019  {$Server =  'KBG-EXCH-3' }
}

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://$server.su.int/PowerShell/" -Authentication Kerberos -Name Exch
Import-PSSession $Session