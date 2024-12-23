//
// MenuCommands.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct MenuCommands: Commands {
  @AppStorage("styleSheet") var styleSheet: StyleSheet = .github
  @AppStorage("editorFontSize") var editorFontSize: Double = 14

  var body: some Commands {
    CommandMenu("Display") {
      ForEach(StyleSheet.allCases, id: \.self) { style in
        Button {
          styleSheet = style
        } label: {
          Text(style == styleSheet ? "✔︎ \(style.rawValue)" : style.rawValue)
        }
        .keyboardShortcut(KeyEquivalent(style.rawValue.first!))
      }

      Divider()

      Menu("Font Size") {
        Button("Smaller") {
          if editorFontSize > 8 {
            editorFontSize -= 1
          }
        }
        .keyboardShortcut("-")

        Button("Reset") {
          editorFontSize = 14
        }
        .keyboardShortcut("0")

        Button("Larger") {
          editorFontSize += 1
        }
        .keyboardShortcut("+")
      }
    }

    CommandGroup(replacing: .help) {
      NavigationLink(
        destination:
          WebView(
            html: nil,
            address: "https://tinyurl.com/markdown-cheatsheet"
          )
          .frame(minWidth: 600, minHeight: 600)
      ) {
        Text("Markdown Help")
      }
    }
  }
}
