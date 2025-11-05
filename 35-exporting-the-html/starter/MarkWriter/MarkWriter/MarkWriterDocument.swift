//
// MarkWriterDocument.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI
import UniformTypeIdentifiers
import MarkdownKit

nonisolated struct MarkWriterDocument: FileDocument {
  var text: String

  var html: String {
    let markdown = MarkdownParser.standard.parse(text)
    return HtmlGenerator.standard.generate(doc: markdown)
  }

  init(text: String = "# Hello, MarkWriter!") {
    self.text = text
  }

  static let readableContentTypes = [
    UTType(importedAs: "net.daringfireball.markdown")
  ]

  init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents,
      let string = String(data: data, encoding: .utf8)
    else {
      throw CocoaError(.fileReadCorruptFile)
    }
    text = string
  }

  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let data = text.data(using: .utf8)!
    return .init(regularFileWithContents: data)
  }
}

extension FocusedValues {
  @Entry var selectedDocument: Binding<MarkWriterDocument>?
}
