//
// ImageEditControls.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ImageEditControls: View {
  @Binding var imageURL: URL?
  @Binding var picture: Picture?

  @State private var picWidth = ""
  @State private var picHeight = ""
  @State private var lockAspectRatio = true
  @State private var picFormat = PicFormat.png

  var body: some View {
    GroupBox {
      HStack {
        EditSizeView(
          picWidth: $picWidth,
          picHeight: $picHeight,
          lockAspectRatio: $lockAspectRatio,
          aspectRatio: picture?.aspectRatio ?? 1
        )

        Spacer()

        Picker("Format:", selection: $picFormat) {
          ForEach(PicFormat.allCases, id: \.self) { format in
            Text(format.rawValue).tag(format)
          }
        }
        .frame(maxWidth: 120)

        Spacer()
        Button("Resize Image") {
          Task {
            await resizeImage()
          }
        }
        .disabled(!pictureHasChanged)
      }
      .padding(.horizontal)
    }
    .padding([.horizontal, .bottom])

    .onChange(of: picture) {
      if let picture {
        picWidth = "\(picture.pixelWidth)"
        picHeight = "\(picture.pixelHeight)"
        picFormat = PicFormat(rawValue: picture.format) ?? .png
      } else {
        picWidth = ""
        picHeight = ""
        picFormat = .png
      }
    }
  }

  var pictureHasChanged: Bool {
    guard let picture else {
      return false
    }

    if picWidth != "\(picture.pixelWidth)" { return true }
    if picHeight != "\(picture.pixelHeight)" { return true }
    if picFormat != PicFormat(rawValue: picture.format) { return true }

    return false
  }

  func resizeImage() async {
  }
}

#Preview {
  ImageEditControls(imageURL: .constant(nil), picture: .constant(nil))
}

struct EditSizeView: View {
  @Binding var picWidth: String
  @Binding var picHeight: String
  @Binding var lockAspectRatio: Bool
  var aspectRatio: Double

  var body: some View {
    HStack {
      VStack {
        HStack {
          Text("Width:").frame(width: 50)
          TextField("", text: $picWidth)
            .frame(maxWidth: 60)
        }
        HStack {
          Text("Height:").frame(width: 50)
          TextField("", text: $picHeight)
            .frame(maxWidth: 60)
        }
      }

      Button {
        toggleAspectRatioLock()
      } label: {
        if lockAspectRatio {
          Image(systemName: "lock")
        } else {
          Image(systemName: "lock.open")
        }
      }
      .font(.title)
      .buttonStyle(.plain)
      .frame(width: 50)
    }
    // onChanges here
  }

  func toggleAspectRatioLock() {
    lockAspectRatio.toggle()
  }

  func adjustAspectRatio(newWidth: String?, newHeight: String?) {
    if !lockAspectRatio {
      return
    }

    if let newWidth, let picWidthValue = Double(newWidth) {
      let newHeight = Int(picWidthValue / aspectRatio)
      picHeight = "\(newHeight)"
    } else if let newHeight, let picHeightValue = Double(newHeight) {
      let newWidth = Int(picHeightValue * aspectRatio)
      picWidth = "\(newWidth)"
    }
  }
}