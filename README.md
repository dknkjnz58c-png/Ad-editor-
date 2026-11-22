# Ad Editor

A short-form (9:16) ad pipeline built on three tools:

| Tool | Job | Install |
| --- | --- | --- |
| [FFmpeg](https://ffmpeg.org) | Cuts + mixes video | `brew install ffmpeg` / `apt install ffmpeg` |
| [HyperFrames](https://github.com/heygen-com/hyperframes) | Captions + graphics (HTML → MP4) | `npm install` (Node 22+) |
| [yt-dlp](https://github.com/yt-dlp/yt-dlp) | Saves the Reels | `pip install -r requirements.txt` |

## Workflow

```bash
npm install
pip install -r requirements.txt

# 1. Download source footage
npm run download -- "https://www.instagram.com/reel/XXXX/" myclip

# 2. Cut 8 seconds starting at 0:03 and reframe to 1080x1920
npm run cut -- media/raw/myclip.mp4 00:00:03 8 ad/assets/clip.mp4

# 3. Edit the headline, captions and CTA in ad/compositions/overlay.html,
#    then preview in the browser
npm run preview

# 4. Render the ad
npm run lint
npm run render            # -> out/ad.mp4

# 5. (Optional) add background music at 25% volume
npm run mix -- out/ad.mp4 media/raw/music.mp3 out/ad-final.mp4
```

## Layout

```
ad/index.html                 # 9:16, 8 s root composition: background clip + overlay
ad/compositions/overlay.html  # headline, timed captions, CTA (GSAP animations)
ad/assets/                    # cut footage goes here (clip.mp4)
scripts/download.sh           # yt-dlp
scripts/cut.sh                # FFmpeg trim + reframe
scripts/mix.sh                # FFmpeg music mix
media/raw, media/cut, out/    # working files (git-ignored)
```

The headline, CTA text and accent color are HyperFrames variables, so you can
change them in the Studio's Variables panel without touching code. To make the
ad longer, raise `data-duration` on `#main`, `#bg-clip` and `#overlay` in
`ad/index.html`.

> Only download videos you own or have permission to use.
