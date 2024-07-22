//
// Day.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import Foundation

struct Day: Decodable {
  let date: String
  let data: [String: [Event]]

  var events: [Event] { data[EventType.events.rawValue] ?? [] }
  var births: [Event] { data[EventType.births.rawValue] ?? [] }
  var deaths: [Event] { data[EventType.deaths.rawValue] ?? [] }

  var displayDate: String {
    date.replacingOccurrences(of: "_", with: " ")
  }
}

extension Day {
  static func emptyDay(date: String) -> Day {
    Day(date: date, data: [:])
  }
}
