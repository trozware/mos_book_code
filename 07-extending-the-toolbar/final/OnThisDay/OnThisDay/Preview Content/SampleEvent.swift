//
// SampleEvent.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

extension Event {
  static var sampleEvent: Event {
    let json =
    """
    {
      "links": {
        "0": {
          "1": "https://wikipedia.org/wiki/48_BC",
          "2": "48 BC"
        },
        "1": {
          "1": "https://wikipedia.org/wiki/Pompey",
          "2": "Pompey"
        },
        "2": {
          "1": "https://wikipedia.org/wiki/Ptolemy_XIII_Theos_Philopator",
          "2": "Ptolemy XIII"
        }
      },
      "text": "0048 BC &#8211; Pompey disembarks at Pelusium upon arriving in Egypt, whereupon he is assassinated by order of King Ptolemy XIII."
    }
    """

    let event = try! JSONDecoder().decode(Event.self, from: Data(json.utf8))
    return event
  }
}
