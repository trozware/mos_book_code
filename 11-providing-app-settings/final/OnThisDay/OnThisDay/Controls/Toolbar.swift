//
// Toolbar.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct Toolbar: CustomizableToolbarContent {
  @AppStorage("showTotals") var showTotals = true
  @Binding var viewMode: ViewMode

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

    ToolbarItem(id: "viewMode") {
      Picker("View Mode", selection: $viewMode) {
        Label("Grid", systemImage: "square.grid.3x2")
          .tag(ViewMode.grid)
          .help("Show the events in a grid.")
        Label("Table", systemImage: "tablecells")
          .tag(ViewMode.table)
          .help("Show the events in a table.")
      }
      .pickerStyle(.segmented)
    }
  }
}
