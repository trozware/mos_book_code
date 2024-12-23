//
// ImageEditView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ImageEditView: View {
  @State private var imageURL: URL?
  @State private var image: NSImage?
  @State private var picture: Picture?
  @State private var showFileImporter = false

  @Binding var selectedTab: TabSelection

  var body: some View {
    VStack {
      HStack {
        Button("Select Image File") {
          showFileImporter = true
        }

        ScrollingPathView(url: $imageURL)
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
    .fileImporter(
      isPresented: $showFileImporter,
      allowedContentTypes: [.image]
    ) { result in
      switch result {
      case .success(let url):
        imageURL = url
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  func getImageData() async {
  }
}

#Preview {
  ImageEditView(selectedTab: .constant(.editImage))
}
