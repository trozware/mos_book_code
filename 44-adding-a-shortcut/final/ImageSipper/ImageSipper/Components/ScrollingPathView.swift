//
// ScrollingPathView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ScrollingPathView: View {
  let url: URL?

  var body: some View {
    ScrollView(.horizontal) {
      if url != nil {
        PathView(url: url)
          .frame(height: 40)
          .padding(.horizontal)
      }
    }
    .background(Color.gray.opacity(0.1))
    .cornerRadius(5)
    .frame(height: 30)
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  ScrollingPathView(url: URL.desktopDirectory)
}
