//
// MarkWriterApp.swift
// macOS by Tutorials
// Version 3.0
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
  }
}
