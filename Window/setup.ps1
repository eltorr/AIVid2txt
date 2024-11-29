Write-Host "Setting up Video Transcription Application..." -ForegroundColor Blue

# Get the root directory (parent of Window folder)
$ROOT_DIR = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $ROOT_DIR

# Create and setup virtual environment
Write-Host "Setting up virtual environment..." -ForegroundColor Green
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Green
pip install -r requirements.txt
deactivate

# Create .streamlit directory and config
Write-Host "Creating Streamlit config..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path frontend\.streamlit | Out-Null
@"
[server]
maxUploadSize = 5120

[browser]
gatherUsageStats = false

[theme]
primaryColor = "#F63366"
backgroundColor = "#FFFFFF"
secondaryBackgroundColor = "#F0F2F6"
textColor = "#262730"
"@ | Out-File -FilePath "frontend\.streamlit\config.toml" -Encoding UTF8

Write-Host "`nSetup complete!" -ForegroundColor Blue
Write-Host "To start the application:" -ForegroundColor Green
Write-Host "Run the deployment script: .\Window\deploy.ps1"

# Check if ffmpeg is installed
if (-not (Get-Command "ffmpeg" -ErrorAction SilentlyContinue)) {
    Write-Host "`nNote: ffmpeg is required but not installed." -ForegroundColor Blue
    Write-Host "Please download and install ffmpeg from the official website:"
    Write-Host "https://ffmpeg.org/download.html"
} 