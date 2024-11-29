# Video Transcription Application

A full-stack application that transcribes video files to text using OpenAI's Whisper model. The application consists of a FastAPI backend and a Streamlit frontend.

## Features

- Upload video files (MP4, AVI, MOV)
- Real-time video transcription
- Download transcription results as text files
- User-friendly web interface
- Cross-platform support (Windows, macOS, Linux)

## Prerequisites

- Python 3.8 or higher
- FFmpeg
- Git
- tmux (for Unix deployment script)

### Installing FFmpeg

- **Ubuntu/Debian**: `sudo apt-get install ffmpeg`
- **macOS**: `brew install ffmpeg`
- **Windows**: Download from the [official FFmpeg website](https://ffmpeg.org/download.html)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd video-transcription-app
   ```

2. Run the setup script for your platform:

   **Unix-based systems (Linux/macOS):**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

   **Windows PowerShell:**
   ```powershell
   .\setup.ps1
   ```

## Running the Application

### Option 1: Using the deployment scripts

**Linux/macOS (using tmux):**

The deployment script uses tmux to manage both services in a single terminal:

```bash
chmod +x deploy.sh
./deploy.sh
```

This will:
- Create a tmux session with split panes for backend and frontend
- Start both services automatically
- Allow you to switch between panes using `Ctrl+B` then arrow keys
- Allow detaching with `Ctrl+B` then `D`
- Reattach using `tmux attach -t video-transcription`

**Windows PowerShell:**
```powershell
.\deploy.ps1
```

This will:
- Check if required ports (8000 and 8501) are available
- Start both services in parallel using PowerShell jobs
- Display real-time output from both services
- Clean up properly when stopped with Ctrl+C
- Services will be available at:
  - Backend: http://localhost:8000
  - Frontend: http://localhost:8501

### Option 2: Manual startup

Start each service in a separate terminal:

1. Start the backend server:
   ```bash
   source .venv/bin/activate
   cd backend
   uvicorn app:app --reload
   ```

2. Start the frontend:
   ```bash
   source .venv/bin/activate
   cd frontend
   streamlit run app.py
   ```

3. Access the application at `http://localhost:8501`

## Project Structure

```
.
├── Linux/                  # Unix/macOS scripts
│   ├── deploy.sh          # Unix deployment script
│   └── setup.sh           # Unix setup script
├── Window/                # Windows scripts
│   ├── deploy.ps1        # Windows deployment script
│   └── setup.ps1         # Windows setup script
├── backend/
│   └── app.py            # FastAPI backend server
├── frontend/
│   └── app.py            # Streamlit frontend application
└── requirements.txt      # Project dependencies
```

## Configuration

The application's configuration is managed through:
- `frontend/.streamlit/config.toml` - Controls Streamlit settings including:
  - Maximum upload size (5120 MB)
  - UI theme customization
  - Usage statistics (disabled by default)

## Dependencies

Key dependencies include:
- FastAPI - Backend API framework
- Streamlit - Frontend framework
- OpenAI Whisper - Speech recognition model
- FFmpeg - Audio processing
- uvicorn - ASGI server

For a complete list of dependencies, see `requirements.txt`.

## Troubleshooting

1. **FFmpeg not found**: Ensure FFmpeg is installed and accessible from the command line
2. **Port conflicts**: Make sure ports 8000 (backend) and 8501 (frontend) are available
3. **Virtual environment issues**: Delete the `.venv` directory and run the setup script again
4. **tmux not found**: Install tmux using your system's package manager (for Unix deployment)

