//
// Toolbar.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct Toolbar: CustomizableToolbarContent {
  @AppStorage("showTotals") var showTotals = true

  var body: some CustomizableToolbarContent {
    ToolbarItem(
      id: "toggleTotals",
      placement: .automatic,
      showsByDefault: true
    ) {
      Toggle(isOn: $showTotals) {
        Label("Show Totals", systemImage: "number")
      }
      .help("Toggle showing totals.")
    }
  }
}
