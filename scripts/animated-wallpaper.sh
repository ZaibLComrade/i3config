#!/bin/bash

# Set wallpaper folder
WALLPAPER_DIR="$HOME/.config/i3/AnimatedWallpapers"
GEOMETRY="1920x1080+0+0"
# GEOMETRY="1366x786+0+0"

# Kill any previous instance that matches our xwinwrap + mpv pattern
pkill -f "xwinwrap.*mpv"

# Pick a random video
file=$(find "$WALLPAPER_DIR" -type f \( -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" \) | shuf -n 1)

# Skip if no file found
[ -e "$file" ] || :

# Start new wallpaper
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


# Launch xwinwrap with optimized mpv settings
# xwinwrap -ni -b -nf -ov -g "$GEOMETRY" \
# -- mpv --wid=%WID \
#    --no-audio \
#    --loop \
#    --really-quiet \
#    --hwdec=vaapi \
#    --vo=gpu \
#    --gpu-context=x11 \
#    --framedrop=vo \
#    --opengl-es=yes \
#    --profile=low-latency \
#    --no-input-default-bindings \
#    --no-config \
#    --scale=bilinear \
#    --deband=no \
#    --osd-level=0 \
#    --demuxer-max-bytes=20480KiB \
#    --vd-lavc-dr=auto \
#    --vd-lavc-film-grain=gpu \
#    --vd-lavc-fast \
#    --vd-lavc-skiploopfilter=nonkey \
#    --vd-lavc-threads=1 \
#    --gpu-dumb-mode=yes \
#    --hwdec-codecs=h264,mpeg2video \
#    "$file" &
