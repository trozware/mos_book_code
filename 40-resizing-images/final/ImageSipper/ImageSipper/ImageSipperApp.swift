//
// ImageSipperApp.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

@main
struct ImageSipperApp: App {
  @State var sipsRunner = SipsRunner()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(sipsRunner)
    }
  }
}
