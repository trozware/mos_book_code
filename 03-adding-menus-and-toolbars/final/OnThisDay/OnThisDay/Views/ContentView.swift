//
// ContentView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @Environment(AppState.self) var appState: AppState

  @State private var eventType: EventType? = .events
  @State private var searchText = ""

  var events: [Event] {
    appState.dataFor(eventType: eventType, searchText: searchText)
  }

  var windowTitle: String {
    if let eventType {
      return "On This Day - \(eventType.rawValue)"
    }
    return "On This Day"
  }

  var body: some View {
    NavigationSplitView(sidebar: {
      SidebarView(selection: $eventType)
    }, detail: {
      GridView(gridData: events)
    })
    .frame(minWidth: 750, minHeight: 450)
    .navigationTitle(windowTitle)
    .toolbar(id: "mainToolbar") {
      Toolbar()
    }
    .searchable(text: $searchText)
  }
}

// #Preview {
//  ContentView()
// }
