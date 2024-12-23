//
// SipsRunner.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation
import Observation

@Observable class SipsRunner {
  var commandRunner = CommandRunner()

  var sipsCommandPath: String?

  func checkSipsCommandPath() async -> String? {
    if sipsCommandPath == nil {
      sipsCommandPath = await commandRunner.pathTo(command: "sips")
    }
    return sipsCommandPath
  }

  func getImageData(for imageURL: URL) async -> String {
    guard let sipsCommandPath = await checkSipsCommandPath() else {
      return ""
    }

    let args = ["--getProperty", "all", imageURL.path(percentEncoded: false)]
    let imageData = await commandRunner.runCommand(sipsCommandPath, with: args)
    return imageData
  }

  func resizeImage(
    picture: Picture,
    newWidth: String,
    newHeight: String,
    newFormat: PicFormat
  ) async -> URL? {
    guard let sipsCommandPath = await checkSipsCommandPath() else {
      return nil
    }

    let fileManager = FileManager.default
    let suffix = "-> \(newWidth) x \(newHeight)"
    var newURL = fileManager.addSuffix(of: suffix, to: picture.url)
    newURL = fileManager.changeFileExtension(
      of: newURL,
      to: newFormat.rawValue
    )

    let args = [
      "--resampleHeightWidth", newHeight, newWidth,
      "--setProperty", "format", newFormat.rawValue,
      picture.url.path(percentEncoded: false),
      "--out", newURL.path(percentEncoded: false),
    ]

    _ = await commandRunner.runCommand(sipsCommandPath, with: args)

    return newURL
  }
}
