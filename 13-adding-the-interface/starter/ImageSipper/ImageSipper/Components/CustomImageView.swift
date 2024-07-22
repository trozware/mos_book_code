//
// CustomImageView.swift
// macOS by Tutorials
// Version 2.0
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
      image = NSImage(contentsOf: imageURL)
    } else {
      image = nil
    }
  }
}

#Preview {
  CustomImageView(imageURL: .constant(nil))
}
