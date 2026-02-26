# ClipStrip

ClipStrip is a macOS menu bar app that strips URL/text metadata from image clipboard entries and keeps the image.

## Install (no Xcode needed)

1. Download `dist/ClipStrip.app.zip`.
2. Unzip it.
3. Move `ClipStrip.app` to `/Applications`.
4. Open it.

If macOS blocks the first launch:

1. Right-click `ClipStrip.app` -> `Open`.
2. Click `Open` again in the confirmation dialog.

## Use

1. Click the ClipStrip icon in the menu bar.
2. Click `Strip URL from Clipboard`.

## Run at login

1. Open System Settings -> General -> Login Items & Extensions.
2. Under `Open at Login`, click `+`.
3. Select `ClipStrip.app`.

## Build from source (optional)

```bash
./build_menubar_app.sh
```
