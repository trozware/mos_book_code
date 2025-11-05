//
// Event.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Foundation

struct Event: Decodable, Identifiable {
  let id = UUID()
  let text: String
  let year: String
  let links: [EventLink]

  enum CodingKeys: String, CodingKey {
    case text
    case links
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let rawText = try values.decode(String.self, forKey: .text)
    var textParts = rawText.components(separatedBy: " &#8211; ")
    if textParts.count == 1 {
      textParts = rawText.components(separatedBy: " &amp;#8211; ")
    }
    if textParts.count == 1 {
      textParts = rawText.components(separatedBy: " – ")
    }

    if textParts.count > 1 {
      year = textParts[0]
      text = textParts[1].decoded
    } else {
      year = "?"
      text = textParts[0].decoded
    }

    let allLinks = try values.decode(
      [String: [String: String]].self,
      forKey: .links)
    var processedLinks: [EventLink] = []
    for (_, link) in allLinks {
      if let title = link["2"],
        let address = link["1"],
        let url = URL(string: address)
      {
        processedLinks.append(EventLink(id: UUID(), title: title, url: url))
      }
    }
    links = processedLinks
  }
}

enum EventType: String, CaseIterable {
  case events = "Events"
  case births = "Births"
  case deaths = "Deaths"
}
