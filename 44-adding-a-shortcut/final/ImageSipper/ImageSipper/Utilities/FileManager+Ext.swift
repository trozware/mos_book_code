//
// FileManager+Ext.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Cocoa
import UniformTypeIdentifiers

extension FileManager {
  // MARK: - Identify URLs

  func isFolder(url: URL) -> Bool {
    var isDir: ObjCBool = false

    if fileExists(atPath: url.path(percentEncoded: false), isDirectory: &isDir) {
      return isDir.boolValue
    }

    return false
  }

  func isImageFile(url: URL) -> Bool {
    guard
      let contentTypeKey = try? url.resourceValues(
        forKeys: [.contentTypeKey])
    else {
      return false
    }

    guard let superTypes = contentTypeKey.contentType?.supertypes else {
      return false
    }

    return superTypes.contains(.image)
  }

  func imageFiles(in url: URL) -> [URL] {
    do {
      let files = try self.contentsOfDirectory(atPath: url.path(percentEncoded: false))
      let imageFiles =
        files
        .map { file in
          url.appendingPathComponent(file)
        }
        .filter { url in
          isImageFile(url: url)
        }
      return imageFiles
    } catch {
      print(error)
      return []
    }
  }

  // MARK: - Create new file paths

  func changeFileExtension(of url: URL, to newExt: String) -> URL {
    let newURL = url.deletingPathExtension().appendingPathExtension(newExt)
    return newURL
  }

  func addSuffix(of suffix: String, to url: URL) -> URL {
    let ext = url.pathExtension
    let fileName =
      url
      .deletingPathExtension()
      .lastPathComponent
      .components(separatedBy: " -> ")[0]
    let newURL = url.deletingLastPathComponent()
    let newPath = "\(fileName) \(suffix).\(ext)"
    return newURL.appendingPathComponent(newPath)
  }
}
