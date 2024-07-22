//
// ThumbControls.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ThumbControls: View {
  var imageURLs: [URL]

  @Environment(SipsRunner.self) var sipsRunner

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

    .alert(Text("Thumbnails created"), isPresented: $showAlert) {
      if let outputFolder {
        Button("Show in Finder") {
          NSWorkspace.shared.selectFile(
            outputFolder.path(percentEncoded: false),
            inFileViewerRootedAtPath: "")
        }
      }

      Button("OK") {}
    } message: {
      Text("\(imageURLs.count) thumbnails have been created.")
    }
  }

  func selectThumbsFolder() {
    let openPanel = NSOpenPanel()
    openPanel.message = "Select the thumbnails folder:"

    openPanel.canCreateDirectories = true
    openPanel.canChooseDirectories = true
    openPanel.canChooseFiles = false
    openPanel.allowsMultipleSelection = false

    openPanel.begin { response in
      if response == .OK, let url = openPanel.url {
        Task {
          await createThumbs(in: url)
        }
      }
    }
  }

  func createThumbs(in folder: URL) async {
    await sipsRunner.createThumbnailFiles(
      in: folder,
      from: imageURLs,
      maxDimension: maxDimension
    )

    outputFolder = folder
    showAlert = true
  }
}

#Preview {
  ThumbControls(imageURLs: [])
    .environment(SipsRunner())
}
