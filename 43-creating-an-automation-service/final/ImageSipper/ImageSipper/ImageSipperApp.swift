//
// ImageSipperApp.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

@main
struct ImageSipperApp: App {
  @State var sipsRunner = SipsRunner()
  var serviceProvider = ServiceProvider()

  @NSApplicationDelegateAdaptor var delegate: AppDelegate

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(sipsRunner)
        .onAppear {
          NSApp.servicesProvider = serviceProvider
        }
    }

    UtilityWindow("Terminal Output", id: Constants.terminalWindowID) {
      TerminalView()
        .environment(sipsRunner.commandRunner)
    }
    .keyboardShortcut("t")
    .defaultWindowPlacement { _, _ in
      let preferredSize = CGSize(width: 300, height: 450)
      return WindowPlacement(.bottomLeading, size: preferredSize)
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
