//
// SidebarView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct SidebarView: View {
  @Binding var selection: EventType?

  var body: some View {
    List(selection: $selection) {
      Section("TODAY") {
        ForEach(EventType.allCases, id: \.self) { type in
          Text(type.rawValue)
        }
      }
    }
    .listStyle(.sidebar)
    .frame(width: 200)
  }
}

#Preview {
  @Previewable @State var selection: EventType?
  SidebarView(selection: $selection)
}
