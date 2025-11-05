//
// SidebarView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct SidebarView: View {
  @Environment(AppState.self) var appState: AppState
  
  @AppStorage("showTotals") var showTotals = true
  @AppStorage("showBirths") var showBirths = true
  @AppStorage("showDeaths") var showDeaths = true
  
  @SceneStorage("selectedDate") var selectedDate: String?
  
  @Binding var selection: EventType?

  var validTypes: [EventType] {
    var types = [EventType.events]
    if showBirths {
      types.append(.births)
    }
    if showDeaths {
      types.append(.deaths)
    }
    return types
  }

  var body: some View {
    List(selection: $selection) {
      Section(selectedDate?.uppercased() ?? "TODAY") {
        ForEach(validTypes, id: \.self) { type in
          Text(type.rawValue)
            .badge(
              showTotals
                ? appState.countFor(eventType: type, date: selectedDate)
                : 0
            )
        }
      }

      Section("SELECT A DATE") {
        DayPicker()
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
          .dateButtonStyle(selected: date == selectedDate)
        }
      }
    }
    .listStyle(.sidebar)
    .frame(width: 225)
  }
}

//  #Preview {
//    @Previewable @State var selection: EventType?
//    SidebarView(selection: $selection)
//  }

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
