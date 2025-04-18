#!/bin/bash

# ~/.config/i3/adjust-brightness.sh
ACTION="$1"
MIN=1        # Minimum brightness percent
MAX=100       # Maximum brightness percent
STEP=5        # How much to increase/decrease

# Get current brightness percentage (strip %)
CURRENT=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
CURRENT_PCT=$((CURRENT * 100 / MAX_BRIGHTNESS))

# Function to clamp value within bounds
clamp() {
  local val=$1
  if (( val < MIN )); then
    echo $MIN
  elif (( val > MAX )); then
    echo $MAX
  else
    echo $val
  fi
}

if [[ "$ACTION" == "up" ]]; then
  TARGET=$((CURRENT_PCT + STEP))
  # ddcutil setvcp 10 + ${STEP}
  # ddcutil setvcp 12 + ${STEP}
elif [[ "$ACTION" == "down" ]]; then
  TARGET=$((CURRENT_PCT - STEP))
  # ddcutil setvcp 10 - ${STEP}
  # ddcutil setvcp 12 - ${STEP}
else
  exit 1
fi

SAFE_TARGET=$(clamp $TARGET)
brightnessctl set "${SAFE_TARGET}%"

