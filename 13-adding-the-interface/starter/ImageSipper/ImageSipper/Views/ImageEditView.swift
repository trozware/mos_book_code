//
// ImageEditView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ImageEditView: View {
  @State private var imageURL: URL?
  @State private var image: NSImage?
  @State private var picture: Picture?
  @Binding var selectedTab: TabSelection

  var body: some View {
    VStack {
      HStack {
        Button {
          // show file importer
        } label: {
          Text("Select Image File")
        }

        // path view here
      }
      .padding()

      CustomImageView(imageURL: $imageURL)

      Spacer()

      ImageEditControls(imageURL: $imageURL, picture: $picture)
        .disabled(picture == nil)
    }
    .onChange(of: imageURL) {
      Task {
        await getImageData()
      }
    }
    // insert fileImporter modifier
  }

  func getImageData() async {
  }
}

#Preview {
  ImageEditView(selectedTab: .constant(.editImage))
}
