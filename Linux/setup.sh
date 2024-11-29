#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Video Transcription Application...${NC}"

# Get the root directory (parent of Linux folder)
ROOT_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
cd "$ROOT_DIR"

# Create and setup backend environment
echo -e "${GREEN}Setting up backend environment...${NC}"
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
deactivate

# Create and setup frontend environment
echo -e "${GREEN}Setting up frontend environment...${NC}"
pip install -r requirements.txt
deactivate

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

echo -e "${BLUE}Setup complete!${NC}"
echo -e "${GREEN}To start the application:${NC}"
echo "Run the deployment script: ./Linux/deploy.sh"

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo -e "\n${BLUE}Note: ffmpeg is required but not installed.${NC}"
    echo "To install ffmpeg:"
    echo "- On Ubuntu/Debian: sudo apt-get install ffmpeg"
    echo "- On MacOS: brew install ffmpeg"
    echo "- On Windows: Please download from the official ffmpeg website"
fi 