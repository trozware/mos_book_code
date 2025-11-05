//
// ServiceProvider.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Cocoa

class ServiceProvider {
  @objc func openFromService(
    _ pboard: NSPasteboard,
    userData: String,
    error: NSErrorPointer
  ) {
    let fileType = NSPasteboard.PasteboardType.fileURL
    guard
      let filePath = pboard.pasteboardItems?.first?
        .string(forType: fileType),
      let url = URL(string: filePath)
    else {
      return
    }

    NSApp.activate()

    let fileManager = FileManager.default

    if fileManager.isFolder(url: url) {
      NotificationCenter.default.post(
        name: .serviceReceivedFolder,
        object: url
      )
    } else if fileManager.isImageFile(url: url) {
      NotificationCenter.default.post(
        name: .serviceReceivedImage,
        object: url
      )
    }
  }
}
