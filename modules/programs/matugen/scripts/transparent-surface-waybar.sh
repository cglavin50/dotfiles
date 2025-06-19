#!/usr/bin/env bash

# Path to your colors.css file
COLOR_FILE="${HOME}/.config/waybar/colors.css"

# Desired alpha (0.0 to 1.0)
ALPHA=0.8

# Extract hex code from @surface definition
SURFACE_HEX=$(grep '@define-color surface ' "$COLOR_FILE" | awk '{print $3}' | tr -d ';#')

# Safety check
if [ -z "$SURFACE_HEX" ]; then
  echo "Could not find @define-color surface in $COLOR_FILE"
  exit 1
fi

# Convert hex to RGB
R=$((16#${SURFACE_HEX:0:2}))
G=$((16#${SURFACE_HEX:2:2}))
B=$((16#${SURFACE_HEX:4:2}))

# Create new transparent color line
RGBA_LINE="@define-color surface_transparent rgba($R, $G, $B, $ALPHA);"

# Remove any previous surface_transparent line (avoid duplicates)
sed -i '/@define-color surface_transparent /d' "$COLOR_FILE"

# Append new transparent color
echo "$RGBA_LINE" >> "$COLOR_FILE"
