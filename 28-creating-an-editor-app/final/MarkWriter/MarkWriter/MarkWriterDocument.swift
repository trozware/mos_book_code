//
// MarkWriterDocument.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
  static var markdownText: UTType {
    UTType(importedAs: "net.daringfireball.markdown")
  }
}

struct MarkWriterDocument: FileDocument {
  var text: String

  init(text: String = "# Hello, MarkWriter!") {
    self.text = text
  }

  static var readableContentTypes: [UTType] { [.markdownText] }

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
