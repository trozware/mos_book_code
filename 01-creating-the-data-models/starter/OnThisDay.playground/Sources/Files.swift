//
// Files.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

public var sampleFileURL: URL {
  URL.downloadsDirectory.appending(path: "SampleData.json")
}

public func saveSampleData(json: String) {
  do {
    try json.write(to: sampleFileURL, atomically: true, encoding: .utf8)
    print("Sample JSON data saved to \(sampleFileURL.path)")
  } catch {
    print(error)
  }
}

public func readSampleData() -> Data? {
  do {
    let data = try Data(contentsOf: sampleFileURL)
    return data
  } catch {
    print(error)
    return nil
  }
}
