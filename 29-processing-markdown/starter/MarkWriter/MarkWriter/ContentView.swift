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

  var body: some View {
    TextEditor(text: $document.text)
  }
}

#Preview {
  ContentView(document: .constant(MarkWriterDocument()))
}
