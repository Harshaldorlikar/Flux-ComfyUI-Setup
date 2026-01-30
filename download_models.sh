#!/bin/bash

# Define Paths
COMFY_DIR="/root/ComfyUI"

echo "🚀 STARTING MODEL DOWNLOADS..."

# 1. Download CLIP Models (T5 and CLIP-L)
# These are public and huge (approx 10GB total).
echo "⬇️ Downloading Text Encoders (T5 + CLIP)..."
cd "$COMFY_DIR/models/clip"

# T5 (FP16 is recommended for 32GB+ RAM, FP8 for lower)
# Since you have an RTX 6000 (48GB VRAM), we get the full FP16 for best quality.
if [ ! -f "t5xxl_fp16.safetensors" ]; then
    echo "   - Downloading t5xxl_fp16.safetensors (9.8 GB)..."
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors
fi

if [ ! -f "clip_l.safetensors" ]; then
    echo "   - Downloading clip_l.safetensors (234 MB)..."
    wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors
fi

# 2. Download VAE
echo "⬇️ Downloading VAE..."
cd "$COMFY_DIR/models/vae"
if [ ! -f "ae.safetensors" ]; then
    echo "   - Downloading ae.safetensors (318 MB)..."
    wget https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors
fi

# 3. Download Upscaler (4x-UltraSharp)
# You need this for the high-res fix.
echo "⬇️ Downloading Upscaler..."
mkdir -p "$COMFY_DIR/models/upscale_models"
cd "$COMFY_DIR/models/upscale_models"
if [ ! -f "4x-UltraSharp.pth" ]; then
    wget https://huggingface.co/LokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth
fi

echo "---------------------------------------------------"
echo "✅ SUPPORT MODELS DOWNLOADED."
echo "---------------------------------------------------"
echo "⚠️  MISSING: The Main 'flux1-dev.safetensors' Model"
echo "You must download 'flux1-dev.safetensors' manually from HuggingFace"
echo "and drag-and-drop it into: /root/ComfyUI/models/unet/"
echo "---------------------------------------------------"