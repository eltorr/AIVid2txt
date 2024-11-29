#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Video Transcription Application...${NC}"

# Create and setup backend environment
echo -e "${GREEN}Setting up backend environment...${NC}"
python -m venv backend/venv
source backend/venv/bin/activate
pip install --upgrade pip
pip install -r backend/requirements.txt
deactivate

# Create and setup frontend environment
echo -e "${GREEN}Setting up frontend environment...${NC}"
python -m venv frontend/venv
source frontend/venv/bin/activate
pip install --upgrade pip
pip install -r frontend/requirements.txt
deactivate

# Create run scripts for both services
echo -e "${GREEN}Creating run scripts...${NC}"

# Create .streamlit directory and config
echo -e "${GREEN}Creating Streamlit config...${NC}"
mkdir -p frontend/.streamlit
cat > frontend/.streamlit/config.toml << 'EOF'
[server]
maxUploadSize = 5120

[browser]
gatherUsageStats = false

[theme]
primaryColor = "#F63366"
backgroundColor = "#FFFFFF"
secondaryBackgroundColor = "#F0F2F6"
textColor = "#262730"
EOF

# Backend run script
cat > run_backend.sh << 'EOF'
#!/bin/bash
source backend/venv/bin/activate
cd backend
uvicorn app:app --reload
EOF

# Frontend run script
cat > run_frontend.sh << 'EOF'
#!/bin/bash
source frontend/venv/bin/activate
cd frontend
streamlit run app.py
EOF

# Make run scripts executable
chmod +x run_backend.sh run_frontend.sh

echo -e "${BLUE}Setup complete!${NC}"
echo -e "${GREEN}To start the application:${NC}"
echo "1. Run the backend: ./run_backend.sh"
echo "2. In a new terminal, run the frontend: ./run_frontend.sh"

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo -e "\n${BLUE}Note: ffmpeg is required but not installed.${NC}"
    echo "To install ffmpeg:"
    echo "- On Ubuntu/Debian: sudo apt-get install ffmpeg"
    echo "- On MacOS: brew install ffmpeg"
    echo "- On Windows: Please download from the official ffmpeg website"
fi 