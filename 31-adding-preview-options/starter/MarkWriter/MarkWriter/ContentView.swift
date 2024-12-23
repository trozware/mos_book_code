//
// ContentView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @Binding var document: MarkWriterDocument

  var body: some View {
    HSplitView {
      TextEditor(text: $document.text)
        .frame(minWidth: 200)
      WebView(html: document.html)
        .frame(minWidth: 200)
    }
    .frame(minHeight: 300)
  }
}

#Preview {
  ContentView(document: .constant(MarkWriterDocument()))
}
