#!/bin/bash
INTERNAL="eDP-1"
EXTERNAL="HDMI-1"

xrandr --output "$INTERNAL" --primary --mode 1366x768 --pos 222x1080 --rotate normal --dpi 82 \
       --output "$EXTERNAL" --mode 1920x1080 --rate 100 --pos 0x0 --rotate normal --dpi 92 \
       --output DP-1 --off --output HDMI-2 --off
