#!/usr/bin/env bash
# Lay a music track under the rendered ad (music at 25%, original audio kept).
# Usage: scripts/mix.sh <video> <music> [output]
set -euo pipefail
video="${1:?usage: mix.sh <video> <music> [output]}"
music="${2:?music file}"
out="${3:-out/ad-final.mp4}"
if ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$video" | grep -q .; then
  filter="[1:a]volume=0.25[m];[0:a][m]amix=inputs=2:duration=first:dropout_transition=2[a]"
else
  filter="[1:a]volume=0.25,apad[a]"
fi
ffmpeg -y -i "$video" -i "$music" -filter_complex "$filter" \
  -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -shortest "$out"
