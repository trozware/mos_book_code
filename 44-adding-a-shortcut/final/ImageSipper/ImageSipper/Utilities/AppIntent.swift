//
// AppIntent.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import AppIntents

struct ShrinkForWeb: AppIntent {
  static let title: LocalizedStringResource = "Shrink for Web"
  static let description = IntentDescription("Shrink an image for web use.")

  @Parameter(title: "Image File", description: "Select the image to shrink for web.")
  var imageFile: IntentFile

  static var parameterSummary: some ParameterSummary {
    Summary("Shrink \(\.$imageFile) for faster web page loads.")
  }

  func perform() async throws -> some IntentResult & ReturnsValue<IntentFile> {
    guard
      let url = imageFile.fileURL,
      await FileManager.default.isImageFile(url: url)
    else {
      throw $imageFile.needsValueError("Select an image file for shrinking.")
    }

    let shrunkURL = await SipsRunner().shrinkForWeb(url)
    guard let shrunkURL else {
      throw $imageFile.needsValueError("The sips command could not be found.")
    }

    let fileIntent = IntentFile(fileURL: shrunkURL)
    return .result(value: fileIntent)
  }
}
