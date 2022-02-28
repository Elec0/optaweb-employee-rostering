# Trying to do this in batch while calling powershell because really annoying.
# Thankfully I found out you can call powershell scripts without guaranteeing the user has 
# the execution policy set, so that's what we're doing.
Start-Service docker -ErrorAction SilentlyContinue
Start-Service com.docker.service -ErrorAction SilentlyContinue

if (!(Get-Process docker -ErrorAction SilentlyContinue)) { 
    $doc = (Resolve-Path ((Get-Item (Get-Command docker).Source).DirectoryName + '../../../')).Path + 'Docker Desktop.exe'

    $proc = New-Object System.Diagnostics.Process -Property @{
        StartInfo = New-Object System.Diagnostics.ProcessStartInfo($doc)
    }

    $proc.Start() | Out-Null
    # docker ps q for if up
    docker ps -q 2>&1>$null
    $e = $?
    while(!$e) {
        Start-Sleep -Milliseconds 500
        docker ps -q 2>&1>$null
        $e = $?
    }
    Write-Output "Docker window should be opening soon."; 
}
else {
    Write-Output  "Docker is already running"
}
