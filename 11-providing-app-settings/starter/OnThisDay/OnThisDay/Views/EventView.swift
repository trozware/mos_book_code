//
// EventView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct EventView: View {
  let event: Event

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 30) {
        Text(event.year)
          .font(.title)

        Text(event.text)
          .font(.title3)

        VStack(alignment: .leading, spacing: 10) {
          Text("Related Links:")
            .font(.title2)

          ForEach(event.links) { link in
            Link(link.title, destination: link.url)
              .onHover { inside in
                if inside {
                  NSCursor.pointingHand.push()
                } else {
                  NSCursor.pop()
                }
              }
          }
        }

        Spacer()
      }
      Spacer()
    }
    .padding()
    .frame(width: 250)
  }
}

#Preview {
  EventView(event: Event.sampleEvent)
}
