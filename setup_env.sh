#!/bin/bash

VENV_DIR=".xai-comparison-env"
REQUIREMENTS="requirements.txt"

# Check if requirements.txt exists
if [ ! -f "$REQUIREMENTS" ]; then
    echo "Error: $REQUIREMENTS not found."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
    echo "Virtual environment created at $VENV_DIR"
else
    echo "Virtual environment already exists at $VENV_DIR"
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"
echo "Virtual environment activated."

# Upgrade pip silently
pip install --upgrade pip -q

# Install packages from requirements.txt
echo "Installing packages from $REQUIREMENTS..."
pip install -r "$REQUIREMENTS"
pip install --upgrade nbformat -q

# ─── Ollama ───────────────────────────────────────────────────────────────────

if ! command -v ollama &> /dev/null; then
    echo "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "Ollama already installed: $(ollama --version)"
fi

# Start Ollama server in background if not running
if ! pgrep -x "ollama" > /dev/null; then
    echo "Starting Ollama server..."
    ollama serve &
    sleep 3  # give it time to start
fi

# Pull llama3.2:3b model
echo "Pulling llama3.2:3b model (this may take a while)..."
ollama pull llama3.2:3b

echo "Done! All packages installed successfully."