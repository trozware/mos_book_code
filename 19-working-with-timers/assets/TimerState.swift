//
// TimerState.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

enum TimerState {
  case runningTask(taskIndex: Int)
  case takingShortBreak(startTime: Date)
  case takingLongBreak(startTime: Date)
  case waiting

  var activeTaskIndex: Int? {
    switch self {
    case .runningTask(let taskIndex):
      return taskIndex
    default:
      return nil
    }
  }

  var breakDuration: TimeInterval? {
    switch self {
    case .takingShortBreak:
      return TaskTimes.shortBreakTime
    case .takingLongBreak:
      return TaskTimes.longBreakTime
    default:
      return nil
    }
  }
}
