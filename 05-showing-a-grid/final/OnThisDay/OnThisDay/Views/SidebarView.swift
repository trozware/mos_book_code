//
// SidebarView.swift
// macOS by Tutorials
// Version 3.0
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
  }
}

#Preview {
  @Previewable @State var selection: EventType?
  SidebarView(selection: $selection)
    .frame(width: 200)
}
