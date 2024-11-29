# Video Transcription App

A web application that extracts and transcribes audio from video files using OpenAI's Whisper model. The application features a Streamlit frontend for easy video upload and a FastAPI backend for processing.

## Features

- Video upload interface with support for files up to 5GB
- Real-time video playback
- Audio extraction using FFmpeg
- Speech-to-text transcription using OpenAI's Whisper
- Downloadable transcript
- Cross-platform support (Windows, macOS, Linux)

## Prerequisites

- Python 3.8 or higher
- FFmpeg installed on your system
  - **Ubuntu/Debian**: `sudo apt-get install ffmpeg`
  - **macOS**: `brew install ffmpeg`
  - **Windows**: Download from [FFmpeg official website](https://ffmpeg.org/download.html)

## Installation

### Unix-like Systems (Linux/macOS)

1. Clone the repository:
```bash
git clone <repository-url>
cd video-transcription-app
```

2. Run the setup script:
```bash
chmod +x setup.sh
./setup.sh
```

3. Start the application:
```bash
# Terminal 1 - Start the backend
./run_backend.sh

# Terminal 2 - Start the frontend
./run_frontend.sh
```

### Windows

1. Clone the repository:
```powershell
git clone <repository-url>
cd video-transcription-app
```

2. Run the setup script:
```powershell
.\setup.ps1
```

3. Start the application:
```powershell
# Terminal 1 - Start the backend
.\run_backend.bat

# Terminal 2 - Start the frontend
.\run_frontend.bat
```

## Usage

1. Open your web browser and navigate to `http://localhost:8501`
2. Upload a video file using the file uploader
3. The video will be displayed in the browser for preview
4. Click the "Transcribe Video" button to start the transcription process
5. Once complete, the transcript will be displayed and available for download

## Project Structure

```
video-transcription-app/
├── backend/
│   ├── app.py              # FastAPI backend application
│   └── requirements.txt    # Backend dependencies
├── frontend/
│   ├── .streamlit/
│   │   └── config.toml    # Streamlit configuration
│   ├── app.py             # Streamlit frontend application
│   └── requirements.txt   # Frontend dependencies
├── setup.sh               # Unix setup script
├── setup.ps1              # Windows setup script
├── run_backend.sh         # Unix backend startup script
├── run_frontend.sh        # Unix frontend startup script
├── run_backend.bat        # Windows backend startup script
├── run_frontend.bat       # Windows frontend startup script
└── README.md
```

## Technical Details

- **Frontend**: Built with Streamlit for a clean and responsive user interface
- **Backend**: FastAPI for efficient video processing and transcription
- **Transcription**: Uses OpenAI's Whisper model for accurate speech-to-text conversion
- **Audio Processing**: FFmpeg for reliable audio extraction from video files

## Limitations

- Maximum file size: 5GB (configurable in `.streamlit/config.toml`)
- Supported video formats: MP4, AVI, MOV
- Processing time depends on video length and system capabilities

## Troubleshooting

1. **FFmpeg not found**: Ensure FFmpeg is installed and accessible from the command line
2. **Port conflicts**: Make sure ports 8000 (backend) and 8501 (frontend) are available
3. **Memory issues**: For large videos, you may need to increase your system's swap space

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.