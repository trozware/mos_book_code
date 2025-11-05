//
// EditSizeView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct EditSizeView: View {
  @Binding var picWidth: String
  @Binding var picHeight: String
  @Binding var lockAspectRatio: Bool
  var aspectRatio: Double

  @FocusState private var widthFieldHasFocus: Bool
  @FocusState private var heightFieldHasFocus: Bool

  var body: some View {
    HStack {
      VStack {
        HStack {
          Text("Width:").frame(width: 50)
          TextField("", text: $picWidth)
            .focused($widthFieldHasFocus)
            .frame(maxWidth: 60)
        }
        HStack {
          Text("Height:").frame(width: 50)
          TextField("", text: $picHeight)
            .focused($heightFieldHasFocus)
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
    .onChange(of: picWidth) { _, newValue in
      if widthFieldHasFocus {
        adjustAspectRatio(newWidth: newValue, newHeight: nil)
      }
    }
    .onChange(of: picHeight) { _, newValue in
      if heightFieldHasFocus {
        adjustAspectRatio(newWidth: nil, newHeight: newValue)
      }
    }
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

#Preview {
  @Previewable @State var picWidth = "800"
  @Previewable @State var picHeight = "600"
  @Previewable @State var lockAspectRatio = true

  EditSizeView(
    picWidth: $picWidth,
    picHeight: $picHeight,
    lockAspectRatio: $lockAspectRatio,
    aspectRatio: 1
  )
}
