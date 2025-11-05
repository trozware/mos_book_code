//
// TaskManager.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Foundation
import Combine

class TaskManager {
  var tasks: [Task] = Task.sampleTasks
  var timerCancellable: AnyCancellable?
  var timerState = TimerState.waiting

  init() {
    startTimer()
  }

  func startTimer() {
    timerCancellable =
      Timer
      .publish(
        every: 1,
        tolerance: 0.5,
        on: .current,
        in: .common
      )
      .autoconnect()
      .sink { time in
        print(time)
      }
  }

  func toggleTask() {
    if let activeTaskIndex = timerState.activeTaskIndex {
      stopRunningTask(at: activeTaskIndex)
    } else {
      startNextTask()
    }
  }

  func startNextTask() {
    let nextTaskIndex = tasks.firstIndex {
      $0.status == .notStarted
    }
    if let nextTaskIndex {
      tasks[nextTaskIndex].start()
      timerState = .runningTask(taskIndex: nextTaskIndex)
    }
  }

  func stopRunningTask(at taskIndex: Int) {
    tasks[taskIndex].complete()
    timerState = .waiting
  }
}
