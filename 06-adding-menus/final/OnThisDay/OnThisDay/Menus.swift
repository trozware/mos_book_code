//
// Menus.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct Menus: Commands {
  @AppStorage("showTotals") var showTotals = true
  @AppStorage("displayMode") var displayMode = DisplayMode.auto

  var body: some Commands {
    SidebarCommands()
    ToolbarCommands()
    InspectorCommands()

    CommandGroup(before: .help) {
      Button("ZenQuotes.io web site") {
        showAPIWebSite()
      }
      .keyboardShortcut("/", modifiers: .command)
    }

    CommandMenu("Display") {
      Toggle(isOn: $showTotals) {
        Text("Show Totals")
      }
      .keyboardShortcut("t", modifiers: .command)

      Divider()

      Picker("Appearance", selection: $displayMode) {
        Text(DisplayMode.light.rawValue)
          .tag(DisplayMode.light)
          .keyboardShortcut("L", modifiers: .command)
        Text(DisplayMode.dark.rawValue)
          .tag(DisplayMode.dark)
          .keyboardShortcut("D", modifiers: .command)
        Text(DisplayMode.auto.rawValue)
          .tag(DisplayMode.auto)
          .keyboardShortcut("U", modifiers: .command)
      }
      .pickerStyle(.inline)
    }
  }

  func showAPIWebSite() {
    let address = "https://today.zenquotes.io"
    guard let url = URL(string: address) else {
      fatalError("Invalid address")
    }
    NSWorkspace.shared.open(url)
  }
}
