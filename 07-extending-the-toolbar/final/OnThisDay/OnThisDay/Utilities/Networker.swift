//
// Networker.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

enum FetchError: Error {
  case badURL
  case badResponse
  case badJSON
}

enum Networker {
  static func getDataForDay(month: Int, day: Int) async throws -> Day {
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

    do {
      let day = try JSONDecoder().decode(Day.self, from: data)
      return day
    } catch {
      print(error)

      // some dates return badly formatted JSON
      do {
        let jsonString = String(decoding: data, as: UTF8.self)
          .replacingOccurrences(of: "\\\",", with: "\",")
        let editedData = Data(jsonString.utf8)
        let day = try JSONDecoder().decode(Day.self, from: editedData)
        return day
      } catch {
        print(error)
      }

      throw FetchError.badJSON
    }
  }
}
