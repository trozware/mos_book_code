//
// SettingsView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    TabView {
      Tab("Show", systemImage: "checkmark.circle") {
        ShowView()
      }
      Tab("Appearance", systemImage: "sun.min") {
        AppearanceView()
      }
    }
    .frame(width: 300, height: 150)
    .navigationTitle("Settings")
  }
}

#Preview("Show") {
  ShowView()
    .frame(width: 200, height: 150)
}

#Preview("Appearance") {
  AppearanceView()
    .frame(width: 200, height: 150)
}
