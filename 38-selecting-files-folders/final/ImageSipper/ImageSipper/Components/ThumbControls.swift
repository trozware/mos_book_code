//
// ThumbControls.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ThumbControls: View {
  var imageURLs: [URL]

  @State private var maxDimension = "128"
  @State private var showAlert = false
  @State private var outputFolder: URL?

  var body: some View {
    GroupBox {
      HStack {
        Text("Maximum Side:")
        TextField("", text: $maxDimension)
          .frame(maxWidth: 60)

        Spacer()

        Button("Save Thumbnails") {
          selectThumbsFolder()
        }
      }
      .padding()
    }
    .padding([.horizontal, .bottom])

    // alert goes here
  }

  func selectThumbsFolder() {
  }

  func createThumbs(in folder: URL) async {
  }
}

#Preview {
  ThumbControls(imageURLs: [])
}
