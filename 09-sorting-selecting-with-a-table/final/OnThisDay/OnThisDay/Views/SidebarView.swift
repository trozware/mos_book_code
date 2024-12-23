//
// SidebarView.swift
// macOS by Tutorials
// Version 3.0
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
  }
}

//  #Preview {
//    @Previewable @State var selection: EventType?
//    SidebarView(selection: $selection)
//      .frame(width: 200)
//  }
