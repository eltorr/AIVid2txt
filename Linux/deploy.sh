#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Video Transcription Application...${NC}"

# Get the root directory (parent of Linux folder)
ROOT_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
cd "$ROOT_DIR"

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install tmux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get install tmux
    else
        echo "Please install tmux manually"
        exit 1
    fi
fi

# Create a new tmux session named 'video-transcription'
tmux new-session -d -s video-transcription

# Split the window horizontally
tmux split-window -h

# Start backend in the first pane
tmux send-keys -t video-transcription:0.0 'source .venv/bin/activate && cd backend && uvicorn app:app --reload' C-m

# Start frontend in the second pane
tmux send-keys -t video-transcription:0.1 'source .venv/bin/activate && cd frontend && streamlit run app.py' C-m

# Attach to the tmux session
echo -e "${GREEN}Starting services...${NC}"
echo "Use 'Ctrl+B' then 'arrow keys' to switch between panes"
echo "Use 'Ctrl+B' then 'D' to detach from the session"
echo "Use 'tmux attach -t video-transcription' to reattach to the session"

tmux attach -t video-transcription 