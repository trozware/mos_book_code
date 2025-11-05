//
// MenuCommands.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct MenuCommands: Commands {
  @AppStorage("styleSheet") var styleSheet: StyleSheet = .default
  @AppStorage("editorFontSize") var editorFontSize: Double = 14

  var body: some Commands {
    CommandMenu("Display") {
      ForEach(StyleSheet.allCases, id: \.self) { style in
        Button {
          styleSheet = style
        } label: {
          if style == styleSheet {
            Label(style.rawValue, systemImage: "checkmark")
          } else {
            Text(style.rawValue)
          }
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
          HTMLView(
            address: "https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
          )
          .frame(minWidth: 600, minHeight: 600)
      ) {
        Text("Markdown Help")
      }
    }
  }
}
