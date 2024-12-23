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
    TextEditor(text: $document.text)
  }
}

#Preview {
  ContentView(document: .constant(MarkWriterDocument()))
}
