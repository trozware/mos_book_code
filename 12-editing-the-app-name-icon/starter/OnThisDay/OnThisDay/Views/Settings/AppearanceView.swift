//
// AppearanceView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct AppearanceView: View {
  @AppStorage("displayMode") var displayMode = DisplayMode.auto

  var body: some View {
    Picker("Display Mode", selection: $displayMode) {
      Text("Light").tag(DisplayMode.light)
      Text("Dark").tag(DisplayMode.dark)
      Text("Automatic").tag(DisplayMode.auto)
    }
    .pickerStyle(.radioGroup)
    .labelsHidden()
  }
}
