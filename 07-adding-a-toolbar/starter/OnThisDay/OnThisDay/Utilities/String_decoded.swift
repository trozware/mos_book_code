//
// String_decoded.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import AppKit

extension String {
  // String extension to decode HTML entities
  var decoded: String {
    let attr = try? NSAttributedString(
      data: Data(utf8),
      options: [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue,
      ],
      documentAttributes: nil)

    return attr?.string ?? self
  }
}
