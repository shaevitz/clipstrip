#!/usr/bin/env bash
set -euo pipefail

APP_NAME="ClipStrip"
SOURCE_FILE="menubar_clipboard_strip.swift"
BUILD_DIR="build"
APP_DIR="${BUILD_DIR}/${APP_NAME}.app"
BIN_DIR="${APP_DIR}/Contents/MacOS"
RES_DIR="${APP_DIR}/Contents/Resources"
BIN_PATH="${BIN_DIR}/${APP_NAME}"
PLIST_PATH="${APP_DIR}/Contents/Info.plist"

if [[ ! -f "${SOURCE_FILE}" ]]; then
  echo "Missing ${SOURCE_FILE} in current directory."
  exit 1
fi

mkdir -p "${BIN_DIR}" "${RES_DIR}"

xcrun swiftc "${SOURCE_FILE}" -framework AppKit -o "${BIN_PATH}"

cat > "${PLIST_PATH}" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDisplayName</key>
  <string>ClipStrip</string>
  <key>CFBundleExecutable</key>
  <string>ClipStrip</string>
  <key>CFBundleIdentifier</key>
  <string>com.local.clipstrip</string>
  <key>CFBundleName</key>
  <string>ClipStrip</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>LSMinimumSystemVersion</key>
  <string>13.0</string>
  <key>LSUIElement</key>
  <true/>
</dict>
</plist>
PLIST

echo "Built ${APP_DIR}"
echo "Launch with: open \"${APP_DIR}\""
