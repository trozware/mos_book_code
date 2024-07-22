//
// AppDelegate.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusItem: NSStatusItem?
  @IBOutlet weak var statusMenu: NSMenu!
  var menuManager: MenuManager?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItem = NSStatusBar.system.statusItem(
      withLength: NSStatusItem.variableLength
    )

    statusItem?.menu = statusMenu

    statusItem?.button?.title = "Time-ato"
    statusItem?.button?.imagePosition = .imageLeading
    statusItem?.button?.image = NSImage(
      systemSymbolName: "timer",
      accessibilityDescription: "Time-ato"
    )

    statusItem?.button?.font = NSFont.monospacedDigitSystemFont(
      ofSize: NSFont.systemFontSize,
      weight: .regular
    )

    menuManager = MenuManager(statusMenu: statusMenu)
    statusMenu.delegate = menuManager
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
