//
// MarkWriterApp.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

@main
struct MarkWriterApp: App {
  var body: some Scene {
    DocumentGroup(newDocument: MarkWriterDocument()) { file in
      ContentView(document: file.$document)
    }
    .commands {
      MenuCommands()
    }
  }
}
