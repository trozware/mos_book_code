//
// Event.swift
// macOS Apps Step by Step
// Version 4.1
//
// by Sarah Reichelt
//

import Foundation

struct Event: Decodable, Identifiable {
  let id = UUID()
  let text: String
  let links: [EventLink]
  let year: String
  
  enum CodingKeys: CodingKey {
    case text
    case links
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let rawText = try container.decode(String.self, forKey: .text)
    let textParts = rawText.components(separatedBy: " – ")
    if textParts.count == 2 {
      year = textParts[0]
      text = textParts[1]
    } else {
      year = "?"
      text = rawText
    }
    
    self.links =
    try container
      .decode([EventLink].self, forKey: .links)
      .filter { link in
        link.url.scheme != nil
      }
  }
}

enum EventType: String, CaseIterable {
  case events = "Events"
  case births = "Births"
  case deaths = "Deaths"
}
