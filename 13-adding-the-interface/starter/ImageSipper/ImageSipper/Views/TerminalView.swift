//
// TerminalView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct TerminalView: View {
  @State private var output = "Terminal output goes here."

  var body: some View {
    VStack {
      Text("Terminal")
        .font(.headline)

      ScrollView {
        Text(output)
          .textSelection(.enabled)
          .font(.system(size: 12, weight: .regular, design: .monospaced))
          .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .padding()
      }
      .foregroundColor(Color("TerminalText"))
      .background(Color("TerminalBg"))
      .border(Color.gray.opacity(0.3))

      Button("Clear Terminal") {
        output = ""
      }
    }
    .frame(minWidth: 300)
    .padding()
  }
}

#Preview {
  TerminalView()
}
