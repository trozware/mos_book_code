//
// ImageSipperApp.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

@main
struct ImageSipperApp: App {
  @State var sipsRunner = SipsRunner()
  var serviceProvider = ServiceProvider()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(sipsRunner)
        .onAppear {
          NSApp.servicesProvider = serviceProvider
        }
    }
  }
}

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

extension Notification.Name {
  static let serviceReceivedImage = Notification.Name("serviceReceivedImage")
  static let serviceReceivedFolder = Notification.Name("serviceReceivedFolder")
}
