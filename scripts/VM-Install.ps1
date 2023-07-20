# Set file and folder path for SSMS installer .exe
$folderpath = "c:\Temp"
$filepath = "$folderpath\SSMS-Setup-ENU.exe"
 
# If SSMS not present, download
if (!(Test-Path $filepath)){
    write-host "Downloading SSMS - SQL Server Management Studio..."
    #$URL = "https://download.microsoft.com/download/3/1/D/31D734E0-BFE8-4C33-A9DE-2392808ADEE6/SSMS-Setup-ENU.exe"
    $URL = "https://aka.ms/ssmsfullsetup"
    $clnt = New-Object System.Net.WebClient
    $clnt.DownloadFile($url,$filepath)
    Write-Host "SSMS installer download completed." -ForegroundColor Green
}
else {
    write-host "SSMS installation binaries already downloaded..."
}
 
# Start SSMS installer
write-host "Beginning SSMS 2016 install..." -nonewline
$Parms = " /Install /Quiet /Norestart /Logs log.txt"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "SSMS installation successfully completed" -ForegroundColor Green