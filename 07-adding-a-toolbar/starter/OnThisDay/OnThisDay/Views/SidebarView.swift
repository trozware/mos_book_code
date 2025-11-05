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
  @Binding var selection: EventType?

  var body: some View {
    List(selection: $selection) {
      Section("TODAY") {
        ForEach(EventType.allCases, id: \.self) { type in
          Text(type.rawValue)
            .badge(
              showTotals
                ? appState.countFor(eventType: type)
                : 0
            )
        }
      }
    }
    .listStyle(.sidebar)
    .frame(width: 200)
  }
}

//  #Preview {
//    @Previewable @State var selection: EventType?
//    SidebarView(selection: $selection)
//  }
