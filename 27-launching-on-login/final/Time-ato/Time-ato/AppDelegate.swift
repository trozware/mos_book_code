//
// AppDelegate.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Cocoa
import SwiftUI
import ServiceManagement

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusItem: NSStatusItem?
  var menuManager: MenuManager?

  @IBOutlet weak var statusMenu: NSMenu!
  @IBOutlet weak var startStopMenuItem: NSMenuItem!
  @IBOutlet weak var launchOnLoginMenuItem: NSMenuItem!

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

  @IBAction func startStopTask(_ sender: Any) {
    menuManager?.taskManager.toggleTask()
  }

  @IBAction func showEditTasksWindow(_ sender: Any) {
    let hostingController = NSHostingController(
      rootView: EditTasksView()
    )

    let window = NSWindow(contentViewController: hostingController)
    window.title = "Edit Tasks"
    let controller = NSWindowController(window: window)

    NSApp.activate()
    controller.showWindow(nil)
  }

  @IBAction func toggleLaunchOnLogin(_ sender: Any) {
    let isSetToLaunchOnLogin = SMAppService.mainApp.status == .enabled
    if isSetToLaunchOnLogin {
      try? SMAppService.mainApp.unregister()
    } else {
      try? SMAppService.mainApp.register()
    }
  }

  func updateMenu(
    title: String,
    icon: String,
    taskIsRunning: Bool
  ) {
    statusItem?.button?.title = title
    statusItem?.button?.image = NSImage(
      systemSymbolName: icon,
      accessibilityDescription: title
    )

    configMenuItemTitles(taskIsRunning: taskIsRunning)

    if menuManager?.menuIsOpen == true {
      menuManager?.refreshMenuItems()
    }
  }

  func configMenuItemTitles(taskIsRunning: Bool) {
    if taskIsRunning {
      startStopMenuItem.title = "Mark Task as Complete"
    } else {
      startStopMenuItem.title = "Start Next Task"
    }

    let isSetToLaunchOnLogin = SMAppService.mainApp.status == .enabled
    launchOnLoginMenuItem.state = isSetToLaunchOnLogin ? .on : .off
  }

  func closeMenu() {
    statusMenu.cancelTracking()
  }

  @IBAction func showAboutBox(_ sender: Any) {
    NSApp.activate()
    NSApp.orderFrontStandardAboutPanel(nil)
  }
}
