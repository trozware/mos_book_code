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
  @State private var dragOver = false

  @Binding var selectedTab: TabSelection

  var body: some View {
    VStack {
      HStack {
        Button("Select Folder of Images") {
          selectImagesFolder()
        }

        ScrollingPathView(url: folderURL)
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
    .onDrop(
      of: [.fileURL],
      isTargeted: $dragOver
    ) { providers in
      if let provider = providers.first {
        provider.loadDataRepresentation(
          forTypeIdentifier: UTType.fileURL.description
        ) { data, _ in
          Task {
            await MainActor.run {
              loadURL(from: data)
            }
          }
        }
      }
      return true
    }
  }

  func selectImagesFolder() {
    let openPanel = NSOpenPanel()
    openPanel.message = "Select a folder of images:"

    openPanel.canChooseDirectories = true
    openPanel.canChooseFiles = false
    openPanel.allowsMultipleSelection = false

    openPanel.begin { response in
      if response == .OK {
        folderURL = openPanel.url
      }
    }
  }

  func loadURL(from data: Data?) {
    guard
      let data,
      let filePath = String(data: data, encoding: .ascii),
      let url = URL(string: filePath)
    else {
      return
    }
    if FileManager.default.isFolder(url: url) {
      folderURL = url
    }
  }
}

#Preview {
  ThumbsView(selectedTab: .constant(.makeThumbs))
}
