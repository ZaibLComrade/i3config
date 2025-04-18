#!/bin/bash

# INPUT_DIR="$HOME/Videos/Wallpaper"
# OUTPUT_DIR="$HOME/.config/i3/AnimatedWallpapers"
# PROCESSED_DIR="$HOME/Videos/BatchedWallpapers"

INPUT_DIR="$HOME/Videos/Wallpaper"
OUTPUT_DIR="$HOME/Videos/TmpV1"
PROCESSED_DIR="$HOME/Videos/Batched2"


mkdir -p "$OUTPUT_DIR"
mkdir -p "$PROCESSED_DIR"

for file in "$INPUT_DIR"/*.{mp4,webm,mkv}; do
  [ -f "$file" ] || continue
  filename=$(basename "$file")

  ffmpeg -i "$file" \
    -vf "scale=1920:1080,fps=30" \
    -c:v libx264 -preset veryfast -crf 23 \
    -an "$OUTPUT_DIR/$filename"

  # Only move original if conversion succeeded
  if [ $? -eq 0 ]; then
    mv "$file" "$PROCESSED_DIR/"
  else
    echo "⚠️ Failed to convert: $filename"
  fi
done

