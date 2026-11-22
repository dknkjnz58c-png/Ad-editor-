#!/usr/bin/env bash
# Trim a clip and reframe it to 1080x1920 (9:16) with FFmpeg.
# Usage: scripts/cut.sh <input> <start> <duration> [output]
#   e.g. scripts/cut.sh media/raw/clip.mp4 00:00:03 8 ad/assets/clip.mp4
set -euo pipefail
in="${1:?usage: cut.sh <input> <start> <duration> [output]}"
start="${2:?start time}"
dur="${3:?duration in seconds}"
out="${4:-ad/assets/clip.mp4}"
mkdir -p "$(dirname "$out")"
ffmpeg -y -ss "$start" -t "$dur" -i "$in" \
  -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30" \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
  -c:a aac -b:a 160k -movflags +faststart "$out"
