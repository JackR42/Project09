[CmdletBinding()]

param 
( 
    [Parameter(ValuefromPipeline=$true,Mandatory=$true)] [string]$Project
)

New-NetFirewallRule -DisplayName "{$Project} - Allow SQL Server inbound" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow
