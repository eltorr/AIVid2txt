#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Video Transcription Application...${NC}"

# Get the root directory (parent of Linux folder)
ROOT_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
cd "$ROOT_DIR"

# Check for required dependencies
echo -e "${GREEN}Checking dependencies...${NC}"

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo -e "\n${BLUE}FFmpeg is required but not installed.${NC}"
    echo "Installing ffmpeg..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ffmpeg
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y ffmpeg
    else
        echo "Please install ffmpeg manually from: https://ffmpeg.org/download.html"
        exit 1
    fi
fi

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo -e "\n${BLUE}tmux is required but not installed.${NC}"
    echo "Installing tmux..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install tmux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y tmux
    else
        echo "Please install tmux manually"
        exit 1
    fi
fi

# Create virtual environment
echo -e "${GREEN}Creating virtual environment...${NC}"
python3 -m venv .venv

# Install dependencies
echo -e "${GREEN}Installing dependencies...${NC}"
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

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

echo -e "${BLUE}Setup complete! Starting the application...${NC}"

# Start backend
cd "${ROOT_DIR}/backend"
source "${ROOT_DIR}/.venv/bin/activate"
uvicorn app:app --reload > backend.log 2>&1 & 
BACKEND_PID=$!

# Start frontend
cd "${ROOT_DIR}/frontend"
streamlit run app.py > frontend.log 2>&1 &
FRONTEND_PID=$!

# Save PIDs to a file for later cleanup
echo $BACKEND_PID > "${ROOT_DIR}/.backend_pid"
echo $FRONTEND_PID > "${ROOT_DIR}/.frontend_pid"

# Display information
echo -e "\n${GREEN}Application is running!${NC}"
echo -e "Backend server running at: ${BLUE}http://localhost:8000${NC}"
echo -e "Frontend available at: ${BLUE}http://localhost:8501${NC}"
echo -e "\nTo view logs:"
echo "  Backend: tail -f backend.log"
echo "  Frontend: tail -f frontend.log"
echo -e "\n${GREEN}To stop the application:${NC}"
echo "  kill $BACKEND_PID $FRONTEND_PID"
echo "  or run: pkill -f 'uvicorn|streamlit'" 