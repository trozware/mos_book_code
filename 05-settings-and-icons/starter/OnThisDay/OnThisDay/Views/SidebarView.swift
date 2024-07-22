//
// SidebarView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct SidebarView: View {
  @Environment(AppState.self) var appState: AppState
  @AppStorage("showTotals") var showTotals = true
  @SceneStorage("selectedDate") var selectedDate: String?

  @Binding var selection: EventType?

  var body: some View {
    VStack {
      List(selection: $selection) {
        Section(selectedDate?.uppercased() ?? "TODAY") {
          ForEach(EventType.allCases, id: \.self) { type in
            Text(type.rawValue)
              .badge(
                showTotals
                ? appState.countFor(eventType: type, date: selectedDate)
                : 0)
          }
        }

        Section("AVAILABLE DATES") {
          ForEach(appState.sortedDates, id: \.self) { date in
            Button {
              selectedDate = date
            } label: {
              HStack {
                Text(date)
                Spacer()
              }
            }
            .controlSize(.large)
            .dateButtonStyle(selected: selectedDate == date)
          }
        }
      }

      Spacer()
      DayPicker()
    }
    .listStyle(.sidebar)
    .frame(minWidth: 200)
  }
}

struct DateButtonViewModifier: ViewModifier {
  let selected: Bool

  func body(content: Content) -> some View {
    if selected {
      content
        .buttonStyle(.borderedProminent)
    } else {
      content
    }
  }
}

extension View {
  func dateButtonStyle(selected: Bool) -> some View {
    self.modifier(DateButtonViewModifier(selected: selected))
  }
}
