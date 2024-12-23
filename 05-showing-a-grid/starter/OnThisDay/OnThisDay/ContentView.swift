//
// ContentView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @State private var eventType: EventType? = .events

  var body: some View {
    NavigationSplitView(
      sidebar: {
        SidebarView(selection: $eventType)
      },
      detail: {
        Text("Fake details")
      }
    )
    .frame(minWidth: 750, minHeight: 450)
  }
}

#Preview {
  ContentView()
}
