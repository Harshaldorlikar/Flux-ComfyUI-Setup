#!/bin/bash

# --- CONFIGURATION ---
COMFY_DIR="/root/ComfyUI"
VENV_DIR="$COMFY_DIR/venv"
# ---------------------

echo "🚀 STARTING BASE INFRASTRUCTURE DEPLOYMENT..."

# 1. System Dependencies (Essential for ComfyUI + Media Handling)
echo "📦 Installing System Libraries..."
apt update && apt install -y python3-venv python3-pip git wget libgl1-mesa-glx libglib2.0-0 build-essential

# 2. Clone ComfyUI Core
if [ ! -d "$COMFY_DIR" ]; then
    echo "⬇️ Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git "$COMFY_DIR"
else
    echo "✅ ComfyUI already exists."
fi

# 3. Create & Activate Virtual Environment
cd "$COMFY_DIR"
if [ ! -d "venv" ]; then
    echo "🐍 Creating Python Virtual Environment..."
    python3 -m venv venv
fi
source "$VENV_DIR/bin/activate"

# 4. Install Torch & Core Python Dependencies
echo "🔌 Installing Torch & Core Requirements..."
# Using cu124 (CUDA 12.4) which matches the RTX 6000 Ada drivers best
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
pip install -r requirements.txt

# 5. Install ComfyUI Manager (The "App Store" - Essential)
echo "🛠 Installing ComfyUI Manager..."
cd custom_nodes
if [ ! -d "ComfyUI-Manager" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
else
    echo "✅ Manager already installed."
fi
cd ..

# 6. Create Model Folders (So they are ready for drag-and-drop)
echo "📂 Pre-creating Flux Model directories..."
mkdir -p models/unet
mkdir -p models/clip
mkdir -p models/vae
mkdir -p models/loras

echo "---------------------------------------------------"
echo "🎉 INFRASTRUCTURE READY!"
echo "---------------------------------------------------"
echo "👉 NEXT STEPS:"
echo "1. Run: source venv/bin/activate"
echo "2. Run: python main.py"
echo "3. Go to Manager -> Install Custom Nodes to get ReActor & Impact Pack."
echo "---------------------------------------------------"