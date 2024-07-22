//
// OnThisDay.playground
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import Cocoa

let appState = AppState()
let monthNum = 2
let dayNum = 29

func testData() {
  if let day = appState.getDataFor(
    month: monthNum, day: dayNum
  ) {
    print(day.displayDate)
    print("\(day.deaths.count) deaths")
  } else {
    print("No data available for that month & day.")
  }
}

extension String {
  // String extension to decode HTML entities
  var decoded: String {
    let attr = try? NSAttributedString(
      data: Data(utf8),
      options: [
        .documentType: NSAttributedString.DocumentType.html,
        .characterEncoding: String.Encoding.utf8.rawValue
      ],
      documentAttributes: nil)

    return attr?.string ?? self
  }
}

enum FetchError: Error {
  case badURL
  case badResponse
  case badJSON
}

func getDataForDay(month: Int, day: Int) async throws -> Day {
  let address = "https://today.zenquotes.io/api/\(month)/\(day)"
  guard let url = URL(string: address) else {
    throw FetchError.badURL
  }
  let request = URLRequest(url: url)

  let (data, response) = try await URLSession.shared.data(for: request)
  guard
    let response = response as? HTTPURLResponse,
    response.statusCode < 400
  else {
    throw FetchError.badResponse
  }

  if let jsonString = String(data: data, encoding: .utf8) {
    saveSampleData(json: jsonString)
  }

  do {
    let day = try JSONDecoder().decode(Day.self, from: data)
    return day
  } catch {
    throw FetchError.badJSON
  }
}

//  Task {
//    do {
//      try await getDataForDay(month: 2, day: 29)
//    } catch {
//      print(error)
//    }
//  }

// if let data = readSampleData() {
//  do {
//    let day = try JSONDecoder().decode(Day.self, from: data)
//    // print(day.displayDate)
//    // print(day.births.count)
//    // print(day.births[0].links)
//    // print(day.births[0].text)
//    // print(day.births[0].year)
//
//    appState.days[day.displayDate] = day
//    testData()
//  } catch {
//    print(error)
//  }
// }

Task {
  do {
    let day = try await getDataForDay(
      month: monthNum,
      day: dayNum
    )
    appState.days[day.displayDate] = day
    testData()
  } catch {
    print(error)
  }
}

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
    let textParts = rawText.components(separatedBy: " &#8211; ")
    if textParts.count == 2 {
      year = textParts[0]
      text = textParts[1].decoded
    } else {
      year = "?"
      text = rawText.decoded
    }

    let allLinks = try values.decode(
      [String: [String: String]].self,
      forKey: .links
    )

    var processedLinks: [EventLink] = []
    for (_, link) in allLinks {
      if
        let title = link["2"],
        let address = link["1"],
        let url = URL(string: address) {
        processedLinks.append(
          EventLink(id: UUID(), title: title, url: url)
        )
      }
    }
    links = processedLinks
  }
}

struct EventLink: Decodable, Identifiable {
  let id: UUID
  let title: String
  let url: URL
}

enum EventType: String {
  case events = "Events"
  case births = "Births"
  case deaths = "Deaths"
}

// 1
class AppState {
  // 2
  var days: [String: Day] = [:]
  // 3
  func getDataFor(month: Int, day: Int) -> Day? {
    let monthName = Calendar.current.monthSymbols[month - 1]
    let dateString = "\(monthName) \(day)"
    return days[dateString]
  }
}
