#!/usr/bin/env bash
# Download a video (e.g. your own Reel) into media/raw/ with yt-dlp.
# Usage: scripts/download.sh <url> [name]
set -euo pipefail
url="${1:?usage: download.sh <url> [name]}"
name="${2:-%(id)s}"
mkdir -p media/raw
yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/b" --merge-output-format mp4 \
  -o "media/raw/${name}.%(ext)s" "$url"
