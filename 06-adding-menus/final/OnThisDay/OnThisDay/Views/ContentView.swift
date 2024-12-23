//
// ContentView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @Environment(AppState.self) var appState: AppState
  @State private var eventType: EventType? = .events

  var events: [Event] {
    appState.dataFor(eventType: eventType)
  }

  var windowTitle: String {
    if let eventType {
      return "On This Day - \(eventType.rawValue)"
    }
    return "On This Day"
  }

  var body: some View {
    NavigationSplitView(
      sidebar: {
        SidebarView(selection: $eventType)
      },
      detail: {
        GridView(gridData: events)
      }
    )
    .frame(minWidth: 750, minHeight: 450)
    .navigationTitle(windowTitle)
  }
}

//  #Preview {
//    ContentView()
//  }
