//
// TerminalView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct TerminalView: View {
  @Environment(CommandRunner.self) var commandRunner

  var body: some View {
    VStack {
      ScrollViewReader { proxy in
        ScrollView {
          Text(commandRunner.output)
            .id(Constants.terminalTextID)
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
        .onChange(of: commandRunner.output) {
          withAnimation {
            proxy.scrollTo(Constants.terminalTextID, anchor: .bottom)
          }
        }
      }

      Button("Clear Terminal") {
        commandRunner.clearOutput()
      }
    }
    .frame(minWidth: 300, minHeight: 450)
    .padding()
  }
}

#Preview {
  TerminalView()
    .environment(CommandRunner())
}
