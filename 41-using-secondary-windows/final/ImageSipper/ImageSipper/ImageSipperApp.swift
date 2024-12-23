//
// ImageSipperApp.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI
import OSLog

@main
struct ImageSipperApp: App {
  @NSApplicationDelegateAdaptor var delegate: AppDelegate

  @State var sipsRunner = SipsRunner()
  @State var logger = Logger(subsystem: "ImageSipper", category: "ImageSipperApp")

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(sipsRunner)
    }

    UtilityWindow("Terminal Output", id: Constants.terminalWindowID) {
      TerminalView()
        .environment(sipsRunner.commandRunner)
    }
    .keyboardShortcut("t")
    .defaultWindowPlacement { _, context in
      let displayBounds = context.defaultDisplay.bounds
      let contentSize = CGSize(width: 300, height: 450)
      let position = CGPoint(
        x: displayBounds.maxX - contentSize.width,
        y: displayBounds.midY - (contentSize.height / 2)
      )

      //  logger.debug("displayBounds: \(displayBounds.debugDescription)")
      //  logger.error("contentSize: \(contentSize.debugDescription)")
      //  logger.fault("position: \(position.debugDescription)")

      return WindowPlacement(position, size: contentSize)
    }
    .restorationBehavior(.disabled)
  }
}

@Observable class AppDelegate: NSObject, NSApplicationDelegate {
  var floatingWindowVisible = false

  func applicationWillUpdate(_ notification: Notification) {
    if let app = notification.object as? NSApplication {
      if let utilWindow = app.windows.first(where: { $0.isFloatingPanel }) {
        floatingWindowVisible = utilWindow.isVisible
      }
    }
  }
}
