//
// SidebarView.swift
// macOS by Tutorials
// Version 2.0
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
  SidebarView(selection: .constant(nil))
    .frame(width: 200)
}
