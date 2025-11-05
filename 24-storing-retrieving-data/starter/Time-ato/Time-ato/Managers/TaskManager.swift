//
// TaskManager.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import AppKit
import Combine

class TaskManager {
  var tasks: [Task] = Task.sampleTasks
  var timerCancellable: AnyCancellable?
  var timerState = TimerState.waiting

  let interaction = Alerter()
  // let interaction = Notifier()

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
      .sink { _ in
        self.checkTimings()
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

    if taskIndex < tasks.count - 1 {
      startBreak(after: taskIndex)
    }
  }

  func checkTimings() {
    let taskIsRunning = timerState.activeTaskIndex != nil

    switch timerState {
    case .runningTask(let taskIndex):
      checkForTaskFinish(activeTaskIndex: taskIndex)
    case .takingShortBreak(let startTime),
      .takingLongBreak(let startTime):
      if let breakDuration = timerState.breakDuration {
        checkForBreakFinish(
          startTime: startTime,
          duration: breakDuration
        )
      }
    default:
      break
    }

    if let appDelegate = NSApp.delegate as? AppDelegate {
      let (title, icon) = menuTitleAndIcon
      appDelegate.updateMenu(
        title: title,
        icon: icon,
        taskIsRunning: taskIsRunning
      )
    }
  }

  func checkForTaskFinish(activeTaskIndex: Int) {
    let activeTask = tasks[activeTaskIndex]

    if activeTask.progressPercent >= 100 {
      if activeTaskIndex == tasks.count - 1 {
        interaction.allTasksComplete()
      } else {
        interaction.taskComplete(
          title: activeTask.title,
          index: activeTaskIndex
        )
      }

      stopRunningTask(at: activeTaskIndex)
    }
  }

  func checkForBreakFinish(startTime: Date, duration: TimeInterval) {
    let elapsedTime = -startTime.timeIntervalSinceNow
    if elapsedTime >= duration {
      timerState = .waiting

      // Uncomment if using Alerter
      let response = interaction.breakOver()
      if response == .alertFirstButtonReturn {
        startNextTask()
      }

      // Uncomment if using Notifier
      // interaction.startNextTaskFunc = startNextTask
      // interaction.breakOver()
    }
  }

  func startBreak(after index: Int) {
    let oneSecondFromNow = Date(timeIntervalSinceNow: 1)
    if (index + 1).isMultiple(of: 4) {
      timerState = .takingLongBreak(startTime: oneSecondFromNow)
    } else {
      timerState = .takingShortBreak(startTime: oneSecondFromNow)
    }
  }
}
