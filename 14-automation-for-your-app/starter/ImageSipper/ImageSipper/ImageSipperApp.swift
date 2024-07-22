//
// ImageSipperApp.swift
// macOS by Tutorials
// Version 2.0
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
