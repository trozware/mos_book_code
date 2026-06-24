//
// EventLink.swift
// macOS Apps Step by Step
// Version 4.1
//
// by Sarah Reichelt
//

import Foundation

struct EventLink: Decodable, Identifiable {
  let text: String
  let url: URL
  var id: URL {
    self.url
  }
}
