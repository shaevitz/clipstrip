# ClipStrip App Store Setup

## 1) Open and configure signing
- Open `ClipStrip.xcodeproj` in Xcode.
- Select target **ClipStrip** -> **Signing & Capabilities**.
- Set your Team.
- Use bundle identifier `com.spider82productions.clipstrip` (or another unique Spider82Productions ID).
- Keep **App Sandbox** enabled.

## 2) Fill required metadata
- In App Store Connect, create a new macOS app record using the same bundle identifier.
- Add privacy policy URL, app description, screenshots, and age rating.

## 3) Add app icon assets
- In `ClipStripApp/Assets.xcassets/AppIcon.appiconset`, add all required macOS icon sizes.
- Include a 1024x1024 icon for App Store submission.

## 4) Archive and upload
- In Xcode, choose **Any Mac (Apple Silicon, Intel)** as destination.
- Product -> Archive.
- In Organizer, click **Distribute App** -> **App Store Connect** -> **Upload**.

## 5) Submit for review
- Wait for build processing in App Store Connect.
- Attach the build to your app version and submit for review.

## Notes
- This project is a menu bar-only app (`LSUIElement = true`), which is valid for macOS App Store.
- Clipboard behavior is local-only and does not require special network entitlements.
