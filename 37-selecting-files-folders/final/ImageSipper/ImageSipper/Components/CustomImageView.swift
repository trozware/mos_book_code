//
// CustomImageView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI
import UniformTypeIdentifiers

struct CustomImageView: View {
  @Binding var imageURL: URL?
  @State private var image: NSImage?

  var body: some View {
    Image(nsImage: image ?? NSImage())
      .resizable()
      .aspectRatio(contentMode: .fit)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.gray.opacity(0.1))
      .cornerRadius(5)
      .padding(.horizontal)
      .padding(.bottom, 12)
      .onChange(of: imageURL) {
        loadImage()
      }
    // onDrop here
  }

  func loadImage() {
    if let imageURL {
      if let newImage = NSImage(contentsOf: imageURL) {
        image = newImage
        return
      }

      let gotAccess = imageURL.startAccessingSecurityScopedResource()
      if gotAccess {
        image = NSImage(contentsOf: imageURL)
        imageURL.stopAccessingSecurityScopedResource()
      } else {
        image = nil
      }
    } else {
      image = nil
    }
  }
}

#Preview {
  CustomImageView(imageURL: .constant(nil))
}
