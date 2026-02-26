import AppKit

private enum ClipboardStripResult {
    case stripped(itemCount: Int)
    case noImageFound
    case emptyPasteboard
}

@main
final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private let statusLine = NSMenuItem(title: "Ready", action: nil, keyEquivalent: "")

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        setupStatusItem()
    }

    @objc private func stripClipboardURL(_ sender: Any?) {
        let result = stripClipboardToImagesOnly()
        switch result {
        case .stripped(let itemCount):
            statusLine.title = "Stripped URL/text from \(itemCount) image item(s)"
        case .noImageFound:
            statusLine.title = "No image found on clipboard"
        case .emptyPasteboard:
            statusLine.title = "Clipboard is empty"
        }
    }

    @objc private func quitApp(_ sender: Any?) {
        NSApp.terminate(nil)
    }

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.title = ""
            button.image = makeStatusIcon()
            button.imagePosition = .imageOnly
            button.toolTip = "ClipStrip"
        }

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Strip URL from Clipboard", action: #selector(stripClipboardURL(_:)), keyEquivalent: "s"))
        menu.addItem(.separator())
        statusLine.isEnabled = false
        menu.addItem(statusLine)
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp(_:)), keyEquivalent: "q"))

        for item in menu.items where item.action != nil {
            item.target = self
        }

        statusItem.menu = menu
    }

    private func makeStatusIcon() -> NSImage {
        let size = NSSize(width: 18, height: 18)
        let image = NSImage(size: size)
        image.lockFocus()

        NSColor.labelColor.setStroke()
        let body = NSBezierPath(roundedRect: NSRect(x: 3, y: 2, width: 12, height: 13), xRadius: 2, yRadius: 2)
        body.lineWidth = 1.6
        body.stroke()

        let clip = NSBezierPath(roundedRect: NSRect(x: 6, y: 13, width: 6, height: 3), xRadius: 1.2, yRadius: 1.2)
        clip.lineWidth = 1.6
        clip.stroke()

        NSColor.systemRed.setStroke()
        let xPath = NSBezierPath()
        xPath.lineWidth = 2.2
        xPath.lineCapStyle = .round
        xPath.move(to: NSPoint(x: 5, y: 5))
        xPath.line(to: NSPoint(x: 13, y: 13))
        xPath.move(to: NSPoint(x: 13, y: 5))
        xPath.line(to: NSPoint(x: 5, y: 13))
        xPath.stroke()

        image.unlockFocus()
        image.isTemplate = false
        return image
    }

    private func stripClipboardToImagesOnly() -> ClipboardStripResult {
        let pb = NSPasteboard.general
        guard let items = pb.pasteboardItems, !items.isEmpty else {
            return .emptyPasteboard
        }

        let imageTypes: [NSPasteboard.PasteboardType] = [
            .tiff,
            .png,
            NSPasteboard.PasteboardType("public.jpeg"),
            NSPasteboard.PasteboardType("public.heic"),
            NSPasteboard.PasteboardType("com.compuserve.gif")
        ]

        var newItems: [NSPasteboardItem] = []

        for item in items {
            let newItem = NSPasteboardItem()
            var foundImage = false

            for type in imageTypes {
                if let data = item.data(forType: type) {
                    newItem.setData(data, forType: type)
                    foundImage = true
                }
            }

            if !foundImage,
               let image = NSImage(pasteboard: pb),
               let tiffData = image.tiffRepresentation {
                newItem.setData(tiffData, forType: .tiff)
                foundImage = true
            }

            if foundImage {
                newItems.append(newItem)
            }
        }

        guard !newItems.isEmpty else {
            return .noImageFound
        }

        pb.clearContents()
        pb.writeObjects(newItems)
        return .stripped(itemCount: newItems.count)
    }
}
