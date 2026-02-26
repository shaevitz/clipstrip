# ClipStrip

ClipStrip is a macOS menu bar app that strips URL/text metadata from image clipboard entries, leaving image data only.

## What it does

- Adds a menu bar icon (clipboard with red X)
- Provides a `Strip URL from Clipboard` action
- Keeps image payloads while removing URL/HTML/plain text clipboard flavors

## Project layout

- `ClipStripApp/` app source, plist, and entitlements
- `ClipStrip.xcodeproj` generated Xcode project
- `project.yml` XcodeGen project definition
- `APP_STORE_SETUP.md` App Store submission notes

## Build in Xcode

1. Open `ClipStrip.xcodeproj`
2. Select target `ClipStrip`
3. Set your team in Signing & Capabilities
4. Run (`Cmd+R`) on `My Mac`

## Regenerate project (optional)

If you change `project.yml`:

```bash
xcodegen generate
```

