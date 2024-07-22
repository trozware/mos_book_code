//
// ContentView.swift
// macOS by Tutorials
// Version 2.0
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
        WebView(html: document.html)
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
    .frame(minWidth: 400, minHeight: 300)
    .toolbar {
      ToolbarItem {
        Picker("", selection: $previewState) {
          Image(systemName: "network")
            .tag(PreviewState.web)
          Image(systemName: "chevron.left.forwardslash.chevron.right")
            .tag(PreviewState.code)
          Image(systemName: "nosign")
            .tag(PreviewState.off)
        }
        .pickerStyle(.segmented)
        .help("Hide preview, show HTML or web view")
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
