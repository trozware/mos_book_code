//
// ThumbsView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI
import UniformTypeIdentifiers

struct ThumbsView: View {
  @State private var folderURL: URL?
  @State private var imageURLs: [URL] = []

  @Binding var selectedTab: TabSelection

  var body: some View {
    VStack {
      HStack {
        Button("Select Folder of Images") {
          selectImagesFolder()
        }

        // path view here
      }
      .padding()

      ScrollView {
        LazyVStack {
          ForEach(imageURLs, id: \.self) { imageURL in
            HStack {
              AsyncImage(url: imageURL) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              } placeholder: {
                ProgressView()
              }
              .frame(width: 100, height: 100)
              .padding(.leading)

              Text(imageURL.lastPathComponent)
              Spacer()
            }
          }
        }
      }
      .background(Color.gray.opacity(0.1))
      .cornerRadius(5)
      .padding(.horizontal)
      .padding(.bottom, 12)

      Spacer()

      ThumbControls(imageURLs: imageURLs)
        .disabled(imageURLs.isEmpty)
    }
    .onChange(of: folderURL) {
      if let folderURL {
        imageURLs = FileManager.default.imageFiles(in: folderURL)
      } else {
        imageURLs = []
      }
    }
    // onDrop here
  }

  func selectImagesFolder() {
  }
}

#Preview {
  ThumbsView(selectedTab: .constant(.makeThumbs))
}
