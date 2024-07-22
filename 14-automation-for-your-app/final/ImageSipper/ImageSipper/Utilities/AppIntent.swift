//
// AppIntent.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import AppIntents

struct ShrinkForWeb: AppIntent {
  static let title: LocalizedStringResource = "Shrink for Web"

  func perform() async throws -> some IntentResult & ReturnsValue<IntentFile> {
    guard
      let url = file.fileURL,
      FileManager.default.isImageFile(url: url)
    else {
      throw $file.needsValueError("Select an image file for shrinking.")
    }

    let shrunkURL = await SipsRunner().shrinkForWeb(url)
    guard let shrunkURL else {
      throw $file.needsValueError("The sips command could not be found.")
    }

    let fileIntent = IntentFile(fileURL: shrunkURL)
    return .result(value: fileIntent)
  }

  static let description = IntentDescription(
    "Shrink an image for use on the web to allow for faster page loads."
  )

  @Parameter(title: "image file") var file: IntentFile

  static var parameterSummary: some ParameterSummary {
    Summary("Shrink \(\.$file) for faster web page loads.")
  }
}
