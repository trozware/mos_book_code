//
// Toolbar.swift
// macOS by Tutorials
// Version 2.0
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
        Label("Show Totals", systemImage: "number.circle")
      }
      .help("Toggle showing totals.")
    }
  }
}
