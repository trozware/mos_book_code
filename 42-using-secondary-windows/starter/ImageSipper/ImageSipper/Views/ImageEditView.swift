//
// ImageEditView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI
import UniformTypeIdentifiers

struct ImageEditView: View {
  @Environment(SipsRunner.self) var sipsRunner

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

        ScrollingPathView(url: imageURL)
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
    guard
      let imageURL,
      FileManager.default.isImageFile(url: imageURL)
    else {
      return
    }

    let imageData = await sipsRunner.getImageData(for: imageURL)
    picture = Picture(url: imageURL, sipsData: imageData)
  }
}

#Preview {
  ImageEditView(selectedTab: .constant(.editImage))
    .environment(SipsRunner())
}
