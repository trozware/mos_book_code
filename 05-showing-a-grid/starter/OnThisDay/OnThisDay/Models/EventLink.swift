//
// EventLink.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

struct EventLink: Decodable, Identifiable {
  let id: UUID
  let title: String
  let url: URL
}
