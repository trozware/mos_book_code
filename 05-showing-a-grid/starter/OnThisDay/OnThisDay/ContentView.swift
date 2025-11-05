//
// ContentView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @State private var eventType: EventType? = .events

  var body: some View {
    HSplitView {
      SidebarView(selection: $eventType)

      Text("Fake details")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .frame(minWidth: 800, minHeight: 450)
  }
}

#Preview {
  ContentView()
}
