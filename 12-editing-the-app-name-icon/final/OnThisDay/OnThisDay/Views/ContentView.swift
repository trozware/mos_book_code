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

  @SceneStorage("eventType") var eventType: EventType?
  @SceneStorage("searchText") var searchText = ""
  @SceneStorage("viewMode") var viewMode: ViewMode = .grid
  @SceneStorage("selectedDate") var selectedDate: String?

  var events: [Event] {
    appState.dataFor(
      eventType: eventType,
      date: selectedDate,
      searchText: searchText
    )
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
        if viewMode == .table {
          TableView(tableData: events)
        } else {
          GridView(gridData: events)
        }
      }
    )
    .frame(minWidth: 750, minHeight: 450)
    .navigationTitle(windowTitle)
    // .toolbar(id: "mainToolbar") {    // put the `id` back once the crashing bug is fixed
    .toolbar {
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

//  #Preview {
//    ContentView()
//  }

enum ViewMode: Int {
  case grid
  case table
}
