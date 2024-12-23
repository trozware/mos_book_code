//
// PathView.swift
// macOS by Tutorials
// Version 3.0
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

    pathControl.target = context.coordinator
    pathControl.doubleAction = #selector(Coordinator.handleDoubleClick)

    return pathControl
  }

  func updateNSView(_ nsView: NSPathControl, context: Context) {
    nsView.url = url
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator()
  }

  class Coordinator {
    @objc func handleDoubleClick(sender: NSPathControl) {
      if let url = sender.clickedPathItem?.url {
        NSWorkspace.shared.selectFile(
          url.path(percentEncoded: false),
          inFileViewerRootedAtPath: ""
        )
      }
    }
  }
}
