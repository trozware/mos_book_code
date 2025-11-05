//
// TableView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct TableView: View {
  let tableData: [Event]

  @State private var sortOrder = [KeyPathComparator(\Event.year)]
  @State private var selectedEventID: Event.ID?
  @State private var showInspector = false

  var sortedTableData: [Event] {
    return tableData.sorted(using: sortOrder)
  }

  var selectedEvent: Event? {
    guard let selectedEventID else {
      return nil
    }

    let event = tableData.first {
      $0.id == selectedEventID
    }
    return event
  }

  var body: some View {
    Table(
      sortedTableData,
      selection: $selectedEventID,
      sortOrder: $sortOrder
    ) {
      TableColumn("Year", value: \.year) {
        Text($0.year)
      }
      .width(min: 50, ideal: 60, max: 100)

      TableColumn("Title", value: \.text)
    }
    .inspector(isPresented: $showInspector) {
      if let selectedEvent {
        EventView(event: selectedEvent)
      } else {
        Text("Select an event to see more info…")
      }
    }
    .onChange(of: selectedEventID) { _, newValue in
      showInspector = newValue != nil
    }
  }
}

extension KeyPath: @unchecked @retroactive Sendable {}

#Preview {
  TableView(tableData: [Event.sampleEvent])
}
