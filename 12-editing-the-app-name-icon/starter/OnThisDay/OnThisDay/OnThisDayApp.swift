//
// OnThisDayApp.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

@main
struct OnThisDayApp: App {
  @AppStorage("displayMode") var displayMode = DisplayMode.auto
  @State var appState = AppState()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(appState)
        .onAppear {
          DisplayMode.changeDisplayMode(to: displayMode)
        }
        .onChange(of: displayMode) { _, newValue in
          DisplayMode.changeDisplayMode(to: newValue)
        }
    }
    .commands {
      Menus()
    }

    Settings {
      SettingsView()
    }
  }
}
