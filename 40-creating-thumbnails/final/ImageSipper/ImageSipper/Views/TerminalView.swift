//
// TerminalView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct TerminalView: View {
  @State private var output = "Terminal output goes here."

  var body: some View {
    VStack {
      ScrollView {
        Text(output)
          .textSelection(.enabled)
          .font(.system(size: 12, weight: .regular, design: .monospaced))
          .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .padding(2)
      }
      .foregroundColor(Color("TerminalText"))
      .background(Color("TerminalBg"))
      .border(Color.gray.opacity(0.3))

      Button("Clear Terminal") {
        output = ""
      }
    }
    .frame(minWidth: 300, minHeight: 450)
    .padding()
  }
}

#Preview {
  TerminalView()
}
