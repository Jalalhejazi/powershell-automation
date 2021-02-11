<#
.Synopsis
   Gets Receive Protocol log entries from Exchange 2013 Front End Transport servers. 
.DESCRIPTION
   Gets entries from the Receive Protocol logs of Exchange 2013 Front End Transport Servers, and produces Powershell
   objects from the retrieved log entries, or optionally returns just the raw entries from the log files.
   Log retrieval can be filtered by Start and End date, and wildcard matches of ConnectorID, SessionID, RemoteEndPoint,
   Event, and Data fields.

.EXAMPLE
   #Get SMTP Recieve events on all FE servers, from 1:20 pm on 01/23/2015 to the end of the log

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00'

.EXAMPLE
   #Get SMTP events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00'

.EXAMPLE
   #Get SMTP events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015, by any connector with 'Relay' in it's name.

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00' -ConnectorID *Relay*

.EXAMPLE
   #Get SMTP events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015,
    by any connector with 'Relay' in it's name, and from address 192.168.65.22.

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00' -ConnectorID *Relay* -RemoteEndpoint 192.168.65.22:*

.EXAMPLE
   #Get SMTP events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015,for SessionID '08D2029FBD5A8E51'

  Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00' -SessionID 08D2029FBD5A8E51

.EXAMPLE
   #Get SMTP Connect and Disconnect events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015, by any connector with 'Relay' in it's name.

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00' -ConnectorID *Relay* -Event [+-]

.EXAMPLE
   #Get SMTP on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015, by any connector with 'Relay' in it's name.

.EXAMPLE
   #Get SMTP Connect and Disconnect events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015,
     where the Data field matches *From*user@domain*

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00' -Data *From*user@domain*

.EXAMPLE
   #Get SMTP Connect and Disconnect events on all FE servers, from 1:20 pm to 1:30 pm on 01.23.2015,
     and return the result as raw lines from the log (not objects)'

   Get-FrontEndSMTPReceiveLog -Start '01/23/2015 13:20:00' -End '01/23/2015 13:30:00' -Raw

.Notes
   Author: Rob Campbell (@mjolinor)
   Last update: 01/23/2015
   Version 1.0
#>
function Get-FrontEndSMTPReceiveLog
{
    [CmdletBinding()]

    Param
    (
        # Server name. Default is '*' (all servers). Wildcards accepted.
        [String]$Server = '*',

        # Log search start date/time.
        [datetime]$Start = [datetime]::MinValue,

        # Log search end date/time.
        [datetime]$End = [datetime]::MaxValue,

        #Connector ID (wildcard filter).
        [string]$ConnectorID = '*',

        #Session ID (wildcard filter).
        [string]$SessionID = '*',

        #Remote Endpoint (wildcard filter).
        [string]$RemoteEndpoint = '*',

        #Event IDs (wildcard filter). Valid values are: + (Connect), - (Disconnect), < (Receive), > (Send) and * (Info). 
        [string]$Event = '*',

        #Data field (wildcard filter).
        [String]$Data = '*',

        #Credential to use for remote server sessions.
        [PSCredential]$Credential,

        #Return raw log data instead of objects
        [Switch]$Raw

    )

    Begin
    {
         $FilterScript = '$_ '

         Switch ( $PSBoundParameters.Keys -match 'Start|End' )
            {
             'Start'
              {
               $StartString = ([datetime]$Start).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fff') 
               $FilterScript += " -gt '$StartString' " 
              }

             'End'
              { 
               $EndString   = ([datetime]$End).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fff')
               $FilterScript += " -lt '$EndString' "
              }
            }
       
        if ($PSBoundParameters.Keys -match 'ConnectorID|SessionID|RemoteEndPoint|Event|Data')
          {
            $FilterString = '*,{0},{1},*,*,{2},{3},{4},*' -f $ConnectorID,$SessionID,$RemoteEndPoint,$Event,$Data
            $FilterScript += " -like '$FilterString'"
          }

       $EventHash = 
       @{
         '+' = 'Connect' 
         '-' = 'Disconnect' 
         '>' = 'Send' 
         '<' = 'Receive'
         '*' = 'Information' 
        }

      $header = @(
       'TimeStamp',
       'ConnectorID',
       'SessionID',
       'SequenceNumber',
       'LocalEndPoint',
       'RemoteEndPoint',
       'Event',
       'Data',
       'Context'
       )
    }#End Begin block

    Process
    {
     #There is no Process block
    }

    End
    {
		TRY {
			$FEServers = Get-FrontendTransportService -Identity $Server -ea Stop
		}
		Catch {
			$FEServers = Get-TransportServer -identity $server
		}

     foreach ($FEServer in $FEServers)
      {
        $LogPath = $FEServer.ReceiveProtocolLogPath

        #Scriptblock for remote invocation.
        $SB = 
        {
          Param (
                 [string]$LogPath,
                 [string]$Start,
                 [string]$End,
                 [string]$FilterScript
                )
         
 
         $Filtersb = [scriptblock]::Create($FilterScript)

         Filter LogFilter {.$Filtersb}

          $AllLogFiles = 
           Get-ChildItem $LogPath -Filter *.log | Sort CreationTime

           if ( $AllLogFiles[-1].CreationTime -le $Start )
            { $Logfiles = $AllLogFiles[-1] }

           else {
                 $Logfiles = $AllLogFiles |
                  Where { 
                     $_.CreationTime -lt [datetime]$End -and
                     $_.LastWriteTime -gt [datetime]$Start
                    }
                 }
                                    
           Foreach ($LogFile in $LogFiles)
             {
               Get-Content $Logfile.FullName -ReadCount 1000 | LogFilter
             }

         } # End remote scriptblock declaration

        $CmdParams = 
        @{
          ComputerName = $FEServer.Name
          ScriptBlock  = $SB
          ArgumentList = $LogPath,$Start,$End,$FilterScript
         }
        
        if ( $PSBoundParameters.ContainsKey('Credential') )
          { $CmdParams.Credential = $Credential }

       Invoke-Command @CmdParams |
       foreach {
        if ($Raw) {$_}
        Else {
              $Record = ConvertFrom-Csv -InputObject $_ -Header $header
              $Record.TimeStamp = [datetime]$Record.TimeStamp
              $Record.Event = $EventHash[$Record.Event]
              $Record
             }

       }#End foreach record
     }#End foreach server
   }#End End block
 } #End Function
