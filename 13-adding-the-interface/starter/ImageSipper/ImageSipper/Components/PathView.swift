//
// PathView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct PathView: NSViewRepresentable {
  var url: URL?

  func makeNSView(context: Context) -> NSPathControl {
    let pathControl = NSPathControl()

    pathControl.isEditable = false
    pathControl.focusRingType = .none
    pathControl.pathStyle = .standard

    return pathControl
  }

  func updateNSView(_ nsView: NSPathControl, context: Context) {
    nsView.url = url
  }
}
