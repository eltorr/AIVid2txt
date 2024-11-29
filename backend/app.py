from fastapi.middleware.cors import CORSMiddleware
import os
import ssl
from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
import whisper
import subprocess
import tempfile

# Add SSL context configuration before model loading
ssl._create_default_https_context = ssl._create_unverified_context

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8501"],  # Streamlit default port
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Initialize Whisper model
model = whisper.load_model("base")

@app.post("/transcribe/")
async def transcribe_video(file: UploadFile = File(...)):
    try:
        # Create temporary files for video and audio
        with tempfile.NamedTemporaryFile(suffix=".mp4", delete=False) as video_tmp:
            # Write uploaded video to temporary file
            video_tmp.write(await file.read())
            video_path = video_tmp.name

        # Extract audio using ffmpeg
        audio_path = video_path + ".wav"
        subprocess.run([
            'ffmpeg', '-i', video_path,
            '-vn', '-acodec', 'pcm_s16le',
            '-ar', '16000', '-ac', '1',
            audio_path
        ], check=True)

        # Transcribe audio using Whisper
        result = model.transcribe(audio_path)

        # Clean up temporary files
        os.unlink(video_path)
        os.unlink(audio_path)

        return JSONResponse({
            "transcript": result["text"],
            "segments": result["segments"]
        })

    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"error": str(e)}
        )

@app.get("/health")
async def health_check():
    return {"status": "healthy"} 