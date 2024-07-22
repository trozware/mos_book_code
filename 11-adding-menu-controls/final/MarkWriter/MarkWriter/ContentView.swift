//
// ContentView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @AppStorage("editorFontSize") var editorFontSize: Double = 14

  @Binding var document: MarkWriterDocument

  @State private var previewState = PreviewState.web
  @State private var showFileExporter = false

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
    .font(.system(size: editorFontSize))
    .focusedValue(\.selectedDocument, $document)
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

      ToolbarItem(placement: .navigation) {
        Button {
          showFileExporter = true
        } label: {
          Label("Export HTML", systemImage: "square.and.arrow.down")
        }
      }
    }
    .fileExporter(
      isPresented: $showFileExporter,
      item: document.html,
      defaultFilename: "Export from toolbar.html"
    ) { result in
      switch result {
        case .success(let url):
          print("File saved to", url)
        case .failure(let error):
          print("Error saving file", error.localizedDescription)
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
