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

### Installing FFmpeg

- **Ubuntu/Debian**: `sudo apt-get install ffmpeg`
- **macOS**: `brew install ffmpeg`
- **Windows**: Download from the [official FFmpeg website](https://ffmpeg.org/download.html)

## Installation & Running

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd video-transcription-app
   ```

2. Run the setup script for your platform:

   **Unix-based systems (Linux/macOS):**
   ```bash
   chmod +x Linux/setup.sh
   ./Linux/setup.sh
   ```

   **Windows PowerShell:**
   ```powershell
   .\Window\setup.ps1
   ```

The setup script will:
- Check and install required dependencies
- Create a Python virtual environment
- Install all Python dependencies
- Configure Streamlit settings
- Start both backend and frontend services
- Display access URLs and log information

Services will be available at:
- Backend: http://localhost:8000
- Frontend: http://localhost:8501

## Project Structure

```
.
├── backend/
│   └── app.py            # FastAPI backend server
├── frontend/
│   ├── .streamlit/       # Streamlit configuration
│   └── app.py            # Streamlit frontend application
├── setup.sh              # Unix setup & deployment script
├── setup.ps1             # Windows setup & deployment script
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
4. **Application not starting**: Check the log files:
   - Backend: `tail -f backend.log`
   - Frontend: `tail -f frontend.log`

To stop the application:
- On Unix: `pkill -f 'uvicorn|streamlit'`
- On Windows: Use Ctrl+C in the terminal running the setup script

