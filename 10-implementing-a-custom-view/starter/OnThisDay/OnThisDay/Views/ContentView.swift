//
// ContentView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @Environment(AppState.self) var appState: AppState

  @SceneStorage("eventType") var eventType: EventType?
  @SceneStorage("searchText") var searchText = ""
  @SceneStorage("viewMode") var viewMode: ViewMode = .grid

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
    HSplitView {
      SidebarView(selection: $eventType)

      if viewMode == .table {
        TableView(tableData: events)
      } else {
        GridView(gridData: events)
      }
    }
    .frame(minWidth: 800, minHeight: 450)
    .navigationTitle(windowTitle)
    .toolbar(id: "mainToolbar") {
      Toolbar(viewMode: $viewMode)
    }
    .searchable(text: $searchText)
    .onAppear {
      if eventType == nil {
        eventType = .events
      }
    }
  }
}

enum ViewMode: Int {
  case grid
  case table
}

//  #Preview {
//    ContentView()
//  }
