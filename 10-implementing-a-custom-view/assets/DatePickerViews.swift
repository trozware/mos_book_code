//
// DatePickerViews.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct DatePickerViews: View {
  @State private var selectedDate = Date()

  var body: some View {
    VStack {
      HStack(alignment: .top) {
        DatePicker(
          "Field", selection: $selectedDate, displayedComponents: [.date]
        )
        .datePickerStyle(.field)

        DatePicker(
          "Graphical", selection: $selectedDate, displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
      }
      .padding()

      Text(selectedDate.description)
    }
  }
}

#Preview {
  DatePickerViews()
}
