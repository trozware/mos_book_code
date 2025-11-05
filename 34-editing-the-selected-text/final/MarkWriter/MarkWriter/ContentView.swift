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

  @State private var previewState = PreviewState.web
  @State private var selection: TextSelection?
  @State private var findInterfaceIsPresented = false

  @AppStorage("editorFontSize") var editorFontSize: Double = 14

  var body: some View {
    HSplitView {
      TextEditor(text: $document.text, selection: $selection)
        .frame(minWidth: 200)
        .findNavigator(isPresented: $findInterfaceIsPresented)

      if previewState == .web {
        HTMLView(html: document.html)
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
    .frame(minHeight: 300)
    .font(.system(size: editorFontSize))
    .focusedValue(\.selectedDocument, $document)
    .toolbar {
      toolbarContent
    }
  }

  func markSelection(with marker: String) {
    switch selection?.indices {
    case .selection(let selectedRange):
      applyStyle(in: selectedRange, with: marker)
    default:
      break
    }
  }

  func applyStyle(in selectedRange: Range<String.Index>, with marker: String) {
    let selectedText = document.text[selectedRange]

    let markerLength = marker.count
    let newText = "\(marker)\(selectedText)\(marker)"

    document.text.replaceSubrange(selectedRange, with: newText)

    let newInsertionPoint = document.text.index(
      selectedRange.upperBound,
      offsetBy: markerLength
    )
    selection = TextSelection(insertionPoint: newInsertionPoint)
  }

  @ToolbarContentBuilder
  var toolbarContent: some ToolbarContent {
    ToolbarItemGroup {
      Button("Bold", systemImage: "bold") {
        markSelection(with: "**")
      }
      .keyboardShortcut("b")
      .help("Make the selected text bold (Cmd B)")

      Button("Italic", systemImage: "italic") {
        markSelection(with: "_")
      }
      .keyboardShortcut("i")
      .help("Make the selected text italic (Cmd I)")
    }

    ToolbarSpacer(.fixed)

    ToolbarItem {
      Button("Code", systemImage: "swift") {
        markSelection(with: "`")
      }
      .keyboardShortcut("k")
      .help("Make the selected text code (Cmd K)")
    }

    ToolbarSpacer(.flexible)

    ToolbarItem {
      Picker("Preview", selection: $previewState) {
        Label("Web", systemImage: "network")
          .tag(PreviewState.web)
          .help("Show web view")
        Label("Code", systemImage: "chevron.left.forwardslash.chevron.right")
          .tag(PreviewState.code)
          .help("Show HTML")
        Label("Off", systemImage: "eye.slash")
          .tag(PreviewState.off)
          .help("Hide preview")
      }
      .pickerStyle(.segmented)
    }

    ToolbarItem {
      Button("Search", systemImage: "magnifyingglass") {
        findInterfaceIsPresented.toggle()
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
