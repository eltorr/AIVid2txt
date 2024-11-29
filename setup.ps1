Write-Host "Setting up Video Transcription Application..." -ForegroundColor Blue

# Create and setup backend environment
Write-Host "Setting up backend environment..." -ForegroundColor Green
python -m venv backend\venv
backend\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r backend\requirements.txt
deactivate

# Create and setup frontend environment
Write-Host "Setting up frontend environment..." -ForegroundColor Green
python -m venv frontend\venv
frontend\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r frontend\requirements.txt
deactivate

# Create run scripts for both services
Write-Host "Creating run scripts..." -ForegroundColor Green

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

# Backend run script
@"
@echo off
call backend\venv\Scripts\activate.bat
cd backend
uvicorn app:app --reload
"@ | Out-File -FilePath "run_backend.bat" -Encoding ASCII

# Frontend run script
@"
@echo off
call frontend\venv\Scripts\activate.bat
cd frontend
streamlit run app.py
"@ | Out-File -FilePath "run_frontend.bat" -Encoding ASCII

Write-Host "Setup complete!" -ForegroundColor Blue
Write-Host "To start the application:" -ForegroundColor Green
Write-Host "1. Run the backend: .\run_backend.bat"
Write-Host "2. In a new terminal, run the frontend: .\run_frontend.bat"

# Check if ffmpeg is installed
if (!(Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "`nNote: ffmpeg is required but not installed." -ForegroundColor Blue
    Write-Host "Please download and install ffmpeg from the official website."
} 