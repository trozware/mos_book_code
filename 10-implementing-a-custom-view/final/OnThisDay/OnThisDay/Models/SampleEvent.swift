//
// SampleEvent.swift
// macOS Apps Step by Step
// Version 4.1
//
// by Sarah Reichelt
//

import Foundation

extension Event {
  static var sampleEvent: Event {
    let json =
      """
      {
        "text": "48 BC – Pompey disembarks at Pelusium upon arriving in Egypt, whereupon he is assassinated by order of King Ptolemy XIII.",
        "links": [
          {
              "text": "48 BC",
              "url": "https://wikipedia.org/wiki/48_BC"
          },
          {
              "text": "Pompey",
              "url": "https://wikipedia.org/wiki/Pompey"
          },
          {
              "text": "Ptolemy XIII",
              "url": "https://wikipedia.org/wiki/Ptolemy_XIII_Theos_Philopator"
          },
          {
              "text": "[1]",
              "url": "#cite_note-Vagi2000-1"
          }
        ]
      }
      """
    
    let event = try! JSONDecoder().decode(Event.self, from: Data(json.utf8))
    return event
  }
}
