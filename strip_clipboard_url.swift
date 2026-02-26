import AppKit

let pb = NSPasteboard.general
guard let items = pb.pasteboardItems, !items.isEmpty else {
    exit(0)
}

var newItems: [NSPasteboardItem] = []

for item in items {
    // Look for common image representations on the pasteboard item.
    // Safari commonly provides TIFF. PNG is sometimes present.
    let imageTypes = [
        NSPasteboard.PasteboardType.tiff,
        NSPasteboard.PasteboardType.png,
        NSPasteboard.PasteboardType("public.jpeg"),
        NSPasteboard.PasteboardType("public.heic"),
        NSPasteboard.PasteboardType("com.compuserve.gif")
    ]

    let newItem = NSPasteboardItem()
    var foundImage = false

    for t in imageTypes {
        if let data = item.data(forType: t) {
            newItem.setData(data, forType: t)
            foundImage = true
        }
    }

    // If we did not find raw image data, try to reconstruct an image from whatever is there.
    // This helps for some apps that only provide a generic image flavor.
    if !foundImage {
        if let img = NSImage(pasteboard: pb),
           let tiffData = img.tiffRepresentation {
            newItem.setData(tiffData, forType: .tiff)
            foundImage = true
        }
    }

    if foundImage {
        newItems.append(newItem)
    }
}

if newItems.isEmpty {
    // No image found, do nothing.
    exit(0)
}

// Clear pasteboard and write back only image items.
// This removes URL, HTML, plain text, etc.
pb.clearContents()
pb.writeObjects(newItems)
