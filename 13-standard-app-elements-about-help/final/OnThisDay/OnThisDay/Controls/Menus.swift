//
// Menus.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct Menus: Commands {
  @AppStorage("showTotals") var showTotals = true
  @AppStorage("displayMode") var displayMode = DisplayMode.auto

  var body: some Commands {
    ToolbarCommands()
    InspectorCommands()

    CommandGroup(replacing: .help) {
      Button("ZenQuotes.io web site", systemImage: "quote.opening") {
        showAPIWebSite()
      }
      .keyboardShortcut("/", modifiers: .command)
    }

    CommandMenu("Display") {
      Toggle(isOn: $showTotals) {
        Image(systemName: "number.circle")
        Text("Show Totals")
      }
      .keyboardShortcut("t", modifiers: .command)

      Divider()

      Picker("Appearance", selection: $displayMode) {
        Label(DisplayMode.light.rawValue, systemImage: "sun.max")
          .tag(DisplayMode.light)
          .keyboardShortcut("L", modifiers: .command)
        Label(DisplayMode.dark.rawValue, systemImage: "sun.max.fill")
          .tag(DisplayMode.dark)
          .keyboardShortcut("D", modifiers: .command)
        Label(DisplayMode.auto.rawValue, systemImage: "person")
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
