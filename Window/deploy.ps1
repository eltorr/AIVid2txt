Write-Host "Starting Video Transcription Application..." -ForegroundColor Blue

# Get the root directory (parent of Window folder)
$ROOT_DIR = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $ROOT_DIR

# Function to check if a port is in use
function Test-PortInUse {
    param($port)
    $listener = $null
    try {
        $listener = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback, $port)
        $listener.Start()
        return $false
    }
    catch {
        return $true
    }
    finally {
        if ($listener) {
            $listener.Stop()
        }
    }
}

# Check if ports are available
if (Test-PortInUse 8000) {
    Write-Host "Error: Port 8000 is already in use. Please free up the port and try again." -ForegroundColor Red
    exit 1
}
if (Test-PortInUse 8501) {
    Write-Host "Error: Port 8501 is already in use. Please free up the port and try again." -ForegroundColor Red
    exit 1
}

# Start backend service
Write-Host "Starting backend service..." -ForegroundColor Green
$backendJob = Start-Job -ScriptBlock {
    Set-Location $using:PWD
    .\.venv\Scripts\Activate.ps1
    cd backend
    uvicorn app:app --reload
}

# Start frontend service
Write-Host "Starting frontend service..." -ForegroundColor Green
$frontendJob = Start-Job -ScriptBlock {
    Set-Location $using:PWD
    .\.venv\Scripts\Activate.ps1
    cd frontend
    streamlit run app.py
}

Write-Host "`nBoth services are starting up..." -ForegroundColor Blue
Write-Host "- Backend will be available at: http://localhost:8000"
Write-Host "- Frontend will be available at: http://localhost:8501"
Write-Host "`nPress Ctrl+C to stop both services`n" -ForegroundColor Yellow

# Display job outputs in real-time
try {
    while ($true) {
        Receive-Job -Job $backendJob
        Receive-Job -Job $frontendJob
        Start-Sleep -Seconds 1
    }
}
finally {
    # Cleanup jobs when script is interrupted
    Write-Host "`nStopping services..." -ForegroundColor Blue
    Stop-Job -Job $backendJob, $frontendJob
    Remove-Job -Job $backendJob, $frontendJob
} 