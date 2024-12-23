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
  @State var appState = AppState()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(appState)
    }
  }
}
