//
// AppState.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation
import Observation

/// AppState is the primary data model for this app.
///
@Observable class AppState {
  /// `days` is a dictionary of Day objects with the keys being the display dates e.g. "June 29"
  var days: [String: Day] = [:]

  /// Properties used for detecting loading states
  var loadingError = false
  var isLoading = false

  /// On `init` start downloading the data for the current day.
  init() {
    Task {
      await getToday()
    }
  }

  /// Returns an array of `Event` objects for the specified parameters.
  /// If a date is specified but there is no data available, trigger a download.
  /// - Parameters:
  ///   - eventType:`EventType`, defaults to `events`
  ///   - date: optional display date e.g. "June 29", uses today's date if not supplied
  ///   - searchText: optional search string to restrict the events returned
  /// - Returns: an array of `Event` objects
  func dataFor(
    eventType: EventType?,
    date: String? = nil,
    searchText: String = ""
  ) -> [Event] {
    let requestedDate = date ?? today
    if let day = days[requestedDate] {
      let events: [Event]
      switch eventType {
        case .births:
          events = day.births
        case .deaths:
          events = day.deaths
        case .events, .none:
          events = day.events
      }

      if searchText.isEmpty {
        return events
      } else {
        let filteredEntries = events.filter { event in
          event.text.localizedStandardContains(searchText)
          || event.year.localizedStandardContains(searchText)
        }
        return filteredEntries
      }
    }

    if let date {
      downloadMissingEvents(for: date)
    }

    return []
  }

  /// Returns the number of `Event` objects for the specified parameters.
  /// - Parameters:
  ///   - eventType:`EventType`, defaults to `events`
  ///   - date: optional display date e.g. "June 29", uses today's date if not supplied
  ///   - searchText: optional search string to restrict the events returned
  /// - Returns: An integer
  func countFor(
    eventType: EventType = .events,
    date: String? = nil,
    searchText: String = ""
  ) -> Int {
    let events = dataFor(eventType: eventType, date: date, searchText: searchText)
    return events.count
  }

  /// Async method to trigger the download of today's `Day`.`
  /// Marked as @MainActor as it will trigger a UI update that must be done on the main thread.
  @MainActor
  func getToday() async {
    let (month, day) = currentMonthAndDay()
    await getDataFor(month: month, day: day)
  }

  /// Method to download the data for the specified month & day, decode it into a `Day`
  /// and add it to `days` which will publish the change
  /// Marked as @MainActor as it will trigger a UI update that must be done on the main thread.
  /// - Parameters:
  ///   - month: month  as integer: January = 1
  ///   - day: day as integer
  @MainActor
  func getDataFor(month: Int, day: Int) async {
    loadingError = false

    isLoading = true
    defer {
      isLoading = false
    }

    let monthName = englishMonthNames[month - 1]
    let dateString = "\(monthName) \(day)"
    if days[dateString] != nil {
      return
    }

    do {
      let newData = try await Networker.getDataForDay(month: month, day: day)
      days[newData.displayDate] = newData
    } catch {
      loadingError = true

      // if decoding fails, store an empty Day to stop trying to download it
      let month = englishMonthNames[month - 1]
      let missingDate = "\(month) \(day)"
      days[missingDate] = Day.emptyDay(date: missingDate)
    }
  }

  /// Get the month number and day number for today.
  /// Defaults to January 1
  /// - Returns: a tuple with two integers: month, day
  func currentMonthAndDay() -> (monthNum: Int, dayNum: Int) {
    let calendarDate = Calendar.current.dateComponents([.day, .month], from: Date())

    if let dayNum = calendarDate.day, let monthNum = calendarDate.month {
      return (monthNum, dayNum)
    }
    return (1, 1)
  }

  /// Computed variable to return the display date for today e.g. "June 29".
  var today: String {
    let (monthNum, dayNum) = currentMonthAndDay()
    let month = englishMonthNames[monthNum - 1]
    return "\(month) \(dayNum)"
  }

  /// Computed variable to return the keys from `days` sorted by date.
  var sortedDates: [String] {
    let dates = days.values.compactMap { day in
      return day.displayDate
    }

    let sortedDates = dates.sorted { lhs, rhs in
      let lhParts = lhs.components(separatedBy: " ")
      let rhParts = rhs.components(separatedBy: " ")
      let lhMonth = lhParts[0]
      let rhMonth = rhParts[0]
      let lhDay = Int(lhParts[1]) ?? 32
      let rhDay = Int(rhParts[1]) ?? 32
      let lhMonthNumber = englishMonthNames.firstIndex(of: lhMonth) ?? 13
      let rhMonthNumber = englishMonthNames.firstIndex(of: rhMonth) ?? 13
      return (lhMonthNumber * 100 + lhDay) < (rhMonthNumber * 100 + rhDay)
    }

    return sortedDates
  }

  /// Method to trigger the download for a date if that date was requested but is not available.
  /// - Parameter date: display date for the specific date  e.g. "June 29".
  func downloadMissingEvents(for date: String) {
    if isLoading {
      return
    }
    isLoading = true

    let dateParts = date.components(separatedBy: " ")
    if dateParts.count < 2 {
      return
    }
    guard let day = Int(dateParts[1]) else {
      return
    }

    guard let monthIndex = englishMonthNames.firstIndex(of: dateParts[0]) else {
      return
    }

    Task {
      await getDataFor(month: monthIndex + 1, day: day)
    }
  }

  /// English month names
  /// Calendar can provide `monthSymbols` but they might not have been in English which the API requires
  var englishMonthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]
}
