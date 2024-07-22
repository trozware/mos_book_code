//
// Alerter.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import AppKit

struct Alerter {
  func taskComplete(title: String, index: Int) {
    var breakLength = "\(Int(TaskTimes.shortBreakTime / 60))"
    if (index + 1).isMultiple(of: 4) {
      breakLength = "\(Int(TaskTimes.longBreakTime / 60))"
    }
    let message = "The \"\(title)\" task is complete.\n\n" +
    "Time to take a \(breakLength) minute break."

    openAlert(title: "Task Complete", message: message, buttonTitles: ["Start Break"])
  }

  func allTasksComplete() {
    let message = "Congratulations!\n\n" +
    "All your tasks for today are complete."

    openAlert(title: "All Tasks Complete", message: message)
  }

  func breakOver() -> NSApplication.ModalResponse {
    let message = "Your break time has finished.\n\n" +
    "Start your next task now or use the menu to start it when you're ready."

    return .alertSecondButtonReturn
  }

  @discardableResult
  func openAlert(title: String, message: String, buttonTitles: [String] = []) -> NSApplication.ModalResponse {
    return .alertFirstButtonReturn
  }
}
