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

echo "Done! All packages installed successfully."