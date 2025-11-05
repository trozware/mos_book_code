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

  @FocusedBinding(\.selectedDocument) var selectedDocument: MarkWriterDocument?

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

    CommandMenu("Markdown") {
      Button("Link") {
        let linkText = "[Title](https://link_to_page)"
        selectedDocument?.text += linkText
      }

      Button("Image") {
        let imageText = "![alt text](https://link_to_image)"
        selectedDocument?.text += imageText
      }

      Button("Divider") {
        let dividerText = "\n\n---\n\n"
        selectedDocument?.text += dividerText
      }

      Button("Code Block") {
        let blockText = """

          ```swift
          print("Hello, world!")
          ```

          """
        selectedDocument?.text += blockText
      }
    }

    CommandGroup(after: .importExport) {
      Button("Export HTML…") {
        exportHTML()
      }
      .disabled(selectedDocument == nil)
    }
  }

  func exportHTML() {
    guard let selectedDocument else {
      return
    }

    let savePanel = NSSavePanel()
    savePanel.title = "Save HTML"
    savePanel.nameFieldStringValue = "Export.html"

    savePanel.begin { response in
      if response == .OK, let url = savePanel.url {
        try? selectedDocument.html.write(
          to: url,
          atomically: true,
          encoding: .utf8
        )
      }
    }
  }
}
