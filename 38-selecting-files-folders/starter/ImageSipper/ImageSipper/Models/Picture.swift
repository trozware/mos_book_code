//
// Picture.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Foundation

struct Picture: Equatable {
  let id = UUID()
  var url: URL
  var pixelHeight: Int
  var pixelWidth: Int
  var format: String

  init(url: URL, sipsData: String) {
    self.url = url

    let sipsLines = sipsData.components(separatedBy: .newlines)

    var picProperties: [String: String] = [:]
    for line in sipsLines {
      let lineParts = line.components(separatedBy: ": ")
      if lineParts.count != 2 {
        continue
      }

      let name = lineParts[0].trimmingCharacters(in: .whitespaces)
      let value = lineParts[1].trimmingCharacters(in: .whitespaces)

      picProperties[name] = value
    }

    pixelHeight = Int(picProperties["pixelHeight"] ?? "0") ?? 0
    pixelWidth = Int(picProperties["pixelWidth"] ?? "0") ?? 0
    format = picProperties["format"] ?? url.pathExtension
  }

  var aspectRatio: Double {
    let width = Double(pixelWidth)
    let height = Double(pixelHeight)

    if height == 0 {
      return 1
    }
    return width / height
  }
}
