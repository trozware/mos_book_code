//
// Task.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import AppKit

struct Task: Identifiable, Codable {
  let id: UUID
  var title: String
  var status: TaskStatus = .notStarted
  var startTime: Date?

  var progressPercent: Double {
    switch status {
    case .notStarted:
      return 0
    case .inProgress:
      if let startTime {
        let elapsedTime = -startTime.timeIntervalSinceNow
        let percentTime = elapsedTime / TaskTimes.taskTime
        return percentTime * 100
      }
      return 0
    case .complete:
      return 100
    }
  }

  mutating func start() {
    status = .inProgress
    startTime = Date(timeIntervalSinceNow: 1)
  }

  mutating func complete() {
    status = .complete
  }

  mutating func reset() {
    status = .notStarted
    startTime = nil
  }
}

extension Task {
  static var sampleTasks: [Task] = [
    Task(id: UUID(), title: "Communications"),
    Task(id: UUID(), title: "Status Meeting"),
    Task(id: UUID(), title: "Project ABC - Ticket 42a"),
    Task(id: UUID(), title: "Project ABC - Ticket 42b"),
    Task(id: UUID(), title: "Project ABC - Ticket 42c"),
    Task(id: UUID(), title: "Testing"),
    Task(id: UUID(), title: "Documentation"),
    Task(id: UUID(), title: "Project ABC - Ticket 123"),
  ]

  static var sampleTasksWithStatus: [Task] = [
    Task(
      id: UUID(),
      title: "Communications",
      status: .complete,
      startTime: Date(timeIntervalSinceNow: -600)
    ),
    Task(
      id: UUID(),
      title: "Status Meeting",
      status: .complete,
      startTime: Date(timeIntervalSinceNow: -300)
    ),
    Task(
      id: UUID(),
      title: "Project ABC - Ticket 42a",
      status: .inProgress,
      startTime: Date(timeIntervalSinceNow: -12)
    ),
    Task(id: UUID(), title: "Project ABC - Ticket 42b"),
    Task(id: UUID(), title: "Project ABC - Ticket 42c"),
    Task(id: UUID(), title: "Testing"),
    Task(id: UUID(), title: "Documentation"),
    Task(id: UUID(), title: "Project ABC - Ticket 123"),
  ]
}
