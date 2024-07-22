//
// DataStore.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import Foundation

struct DataStore {
  var dataFileURL: URL {
    URL.documentsDirectory.appending(path: "Timeato_Tasks.json")
  }

  func readTasks() -> [Task] {
    do {
      let data = try Data(contentsOf: dataFileURL)
      let tasks = try JSONDecoder()
        .decode([Task].self, from: data)
      return tasks
    } catch {
      print("Read error: \(error.localizedDescription)")
      return []
    }
  }

  func save(tasks: [Task]) {
    guard let data = try? JSONEncoder().encode(tasks) else {
      return
    }
    do {
      try data.write(to: dataFileURL)
    } catch {
      print("Save error: \(error.localizedDescription)")
    }
  }
}

extension Notification.Name {
  static let dataRefreshNeeded =
  Notification.Name("dataRefreshNeeded")
}
