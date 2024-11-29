import streamlit as st
import requests
import tempfile
import os
from pathlib import Path

st.title("Video Transcription App")

# File uploader
video_file = st.file_uploader("Upload a video file", type=['mp4', 'avi', 'mov'])

if video_file is not None:
    # Save the video file temporarily
    temp_path = Path(tempfile.mkdtemp()) / "temp_video.mp4"
    temp_path.write_bytes(video_file.read())
    
    # Display the video
    st.video(str(temp_path))
    
    if st.button("Transcribe Video"):
        with st.spinner("Transcribing..."):
            # Send the video file to the backend
            files = {"file": open(str(temp_path), "rb")}
            response = requests.post("http://localhost:8000/transcribe/", files=files)
            
            if response.status_code == 200:
                data = response.json()
                transcript = data["transcript"]
                
                # Display transcript
                st.header("Transcript")
                st.write(transcript)
                
                # Download button for transcript
                st.download_button(
                    label="Download Transcript",
                    data=transcript,
                    file_name="transcript.txt",
                    mime="text/plain"
                )
            else:
                st.error("Error during transcription. Please try again.")
        
        # Clean up temporary file
        os.unlink(str(temp_path)) 