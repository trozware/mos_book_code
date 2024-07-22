//
// GridView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct GridView: View {
  let gridData: [Event]

  var columns: [GridItem] {
    [GridItem(.adaptive(minimum: 250, maximum: 250), spacing: 20)]
  }

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 15) {
        ForEach(gridData) {
          EventView(event: $0)
            .frame(height: 350, alignment: .topLeading)
            .background()
            .clipped()
            .compositingGroup()
            .border(.secondary, width: 1)
            .padding(.bottom, 5)
            .shadow(color: .primary.opacity(0.3), radius: 3, x: 3, y: 3)
        }
      }
      .padding(.vertical)
    }
  }
}

#Preview {
  GridView(gridData: [Event.sampleEvent])
    .frame(width: 300, height: 400)
}
