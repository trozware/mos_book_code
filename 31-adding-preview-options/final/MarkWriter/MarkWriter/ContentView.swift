//
// ContentView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @Binding var document: MarkWriterDocument
  @State private var previewState = PreviewState.web

  var body: some View {
    HSplitView {
      TextEditor(text: $document.text)
        .frame(minWidth: 200)
      if previewState == .web {
        HTMLView(html: document.html)
          .frame(minWidth: 200)
      } else if previewState == .code {
        ScrollView {
          Text(document.html)
            .frame(minWidth: 200)
            .frame(
              maxWidth: .infinity,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .padding()
            .textSelection(.enabled)
        }
      }
    }
    .frame(minHeight: 300)
    .toolbar {
      ToolbarItem {
        Picker("Preview", selection: $previewState) {
          Image(systemName: "network")
            .tag(PreviewState.web)
            .help("Show web view")
          Image(systemName: "chevron.left.forwardslash.chevron.right")
            .tag(PreviewState.code)
            .help("Show HTML")
          Image(systemName: "eye.slash")
            .tag(PreviewState.off)
            .help("Hide preview")
        }
        .pickerStyle(.segmented)
      }
    }
  }
}

#Preview {
  ContentView(document: .constant(MarkWriterDocument()))
}

enum PreviewState {
  case web
  case code
  case off
}
