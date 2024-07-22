//
// TaskManagerExt.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import Foundation

extension TaskManager {
  var menuTitleAndIcon: (title: String, icon: String) {
    switch timerState {
      case .runningTask(let taskIndex):
        let task = tasks[taskIndex]
        if let startTime = task.startTime {
          let remainingTime = differenceToHourMinFormat(
            start: startTime,
            duration: TaskTimes.taskTime
          )
          return ("\(task.title) - \(remainingTime)", task.status.iconName)
        } else {
          return ("Time-ato", "timer")
        }
      case .takingShortBreak(let startTime):
        let remainingTime = differenceToHourMinFormat(
          start: startTime,
          duration: TaskTimes.shortBreakTime)
        return ("Short Break - \(remainingTime)", "cup.and.saucer")
      case .takingLongBreak(let startTime):
        let remainingTime = differenceToHourMinFormat(
          start: startTime,
          duration: TaskTimes.longBreakTime)
        return ("Long Break - \(remainingTime)", "figure.walk")
      case .waiting:
        return ("Time-ato", "timer")
    }
  }

  func differenceToHourMinFormat(start: Date, duration: TimeInterval) -> String {
    let endTime = start.addingTimeInterval(duration)
    let remainingTime = endTime.timeIntervalSince(Date())
    if let difference = dateFormatter.string(from: remainingTime) {
      return difference
    }
    return ""
  }
}

var dateFormatter: DateComponentsFormatter = {
  let formatter = DateComponentsFormatter()
  formatter.allowedUnits = [.minute, .second]
  formatter.zeroFormattingBehavior = .pad
  return formatter
}()
