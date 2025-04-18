#!/bin/bash

# Set wallpaper folder
WALLPAPER_DIR="$HOME/.config/i3/AnimatedWallpapers"

# Set how long each wallpaper should play (in seconds)
DURATION=3600
GEOMETRY="1920x1080+0+0"

# Kill any existing xwinwrap/mpv loops
pkill xwinwrap
pkill mpv

# Initialize wallpaper PID to nothing
CURRENT_PID=""

# Loop forever
while true; do
  # Get a shuffled list of video files
  for file in $(find "$WALLPAPER_DIR" -type f \( -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" \) | shuf); do
    [ -e "$file" ] || continue  # Skip if no matching files

    xwinwrap -ni -b -nf -ov -g "$GEOMETRY" \
-- mpv --wid=%WID \
  --no-audio \
  --loop \
  --really-quiet \
  --hwdec=vaapi \
  --vo=gpu \
  --gpu-context=x11egl \
  --framedrop=vo \
  --opengl-es=yes \
  --profile=low-latency \
  --no-input-default-bindings \
  --no-config \
  --scale=bilinear \
  --deband=no \
  "$file" &


    NEW_PID=$!

    # Kill the previous wallpaper after the new one starts
    if [ -n "$CURRENT_PID" ]; then
      kill "$CURRENT_PID"
      wait "$CURRENT_PID" 2>/dev/null
    fi

    CURRENT_PID=$NEW_PID
    sleep "$DURATION"
  done
done

