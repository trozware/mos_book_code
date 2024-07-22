//
// ImageEditView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ImageEditView: View {
  @Environment(SipsRunner.self) var sipsRunner

  @State private var imageURL: URL?
  @State private var image: NSImage?
  @State private var picture: Picture?
  @Binding var selectedTab: TabSelection
  @State private var showFileImporter = false

  let serviceReceivedImageNotification = NotificationCenter.default
    .publisher(for: .serviceReceivedImage)
    .receive(on: RunLoop.main)

  var body: some View {
    VStack {
      HStack {
        Button {
          // show file importer
          showFileImporter = true
        } label: {
          Text("Select Image File")
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
    .onReceive(serviceReceivedImageNotification) { notification in
      if let url = notification.object as? URL {
        selectedTab = .editImage
        imageURL = url
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
