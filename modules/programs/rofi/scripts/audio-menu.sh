#!/usr/bin/env bash

curr_sink=$(wpctl status | 
awk '
  /Sinks/ && !found { in_block=1; next }
  /Sources/ && in_block { in_block=0; found=1; exit }
  in_block {
    if ($0 ~ /\*/) {
      # Find first digit position
      start = match($0, /[0-9]/)
      rest = substr($0, start)
      # Find first [ position after digit
      end_offset = match(rest, /\[/)
      if (end_offset > 0) {
        print substr($0, start, end_offset - 1)
      } else {
        print substr($0, start)
      }
      exit
    }
  }
')
curr_source=$(wpctl status | 
awk '
  /Sources/ && !found { in_block=1; next }
  /Fitlers/ && in_block { in_block=0; found=1; exit }
  in_block {
    if ($0 ~ /\*/) {
      # Find first digit position
      start = match($0, /[0-9]/)
      rest = substr($0, start)
      # Find first [ position after digit
      end_offset = match(rest, /\[/)
      if (end_offset > 0) {
        print substr($0, start, end_offset - 1)
      } else {
        print substr($0, start)
      }
      exit
    }
  }
')
echo "$curr_source"

sinks=$(wpctl status | awk '
  /Sinks/ { in_block = 1; next }
  /Sources/ { in_block = 1; exit }
  in_block
' | sed 's/^[^0-9]*//' | sed 's/  *\[vol:.*$//')

echo $sinks

sources=$(wpctl status | awk '
  /Sources/ { in_block = 1; next }
  /Filters/ { in_block = 1; exit }
  in_block && /^\s*\|/ {
    line = $0
    sub(/^\s*\|[[:space:]]*/, "", line)
    print line
  }
')

media=$(playerctl metadata --format "{{artist}} - {{title}}" 2>/dev/null || echo "No media playing")

selection=$(echo "$sinks" | rofi -dmenu -p "Select Audio Sink" -theme ~/.config/rofi/themes/volume.rasi)
echo "$selection"
sink_id=$(echo "$selection" | sed 's/^\([0-9]\+\)\..*$/\1/')
echo "$sink_id"

if [ -n "$sink_id" ]; then
  wpctl set-default "$sink_id"
fi
