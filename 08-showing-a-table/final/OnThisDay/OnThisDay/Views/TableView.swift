//
// TableView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct TableView: View {
  let tableData: [Event]

  var body: some View {
    Table(tableData) {
      TableColumn("Year") {
        Text($0.year)
      }
      .width(min: 50, ideal: 60, max: 100)

      TableColumn("Title") {
        Text($0.text)
      }
    }
  }
}

#Preview {
  TableView(tableData: [Event.sampleEvent])
}
