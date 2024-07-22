//
// Menus.swift
// macOS by Tutorials
// Version 2.0
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

    CommandGroup(replacing: .help) {
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
        ForEach(DisplayMode.allCases, id: \.self) {
          Text($0.rawValue)
            .tag($0)
        }
      }

      ////  Alternative menu items for Appearance.
      //  Menu("Appearance") {
      //    Button("Light") {
      //      displayMode = .light
      //    }
      //    .keyboardShortcut("L")
      //
      //    Button("Dark") {
      //      displayMode = .dark
      //    }
      //    .keyboardShortcut("D")
      //
      //    Button("Auto") {
      //      displayMode = .auto
      //    }
      //    .keyboardShortcut("U")
      //  }
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
