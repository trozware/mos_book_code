//
// EditButtonsView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct EditButtonsView: View {
  @Binding var tasks: [Task]
  let dataStore: DataStore

  var body: some View {
    HStack {
      Button("Cancel", role: .cancel) {
        closeWindow()
      }
      .keyboardShortcut(.cancelAction)

      Spacer()

      Button("Mark All Incomplete") {
        markAllTasksIncomplete()
      }

      Spacer()

      Button("Save") {
        saveTasks()
      }
    }
    .padding(12)
  }

  func closeWindow() {
    NSApp.keyWindow?.close()
  }

  func saveTasks() {
    tasks = tasks.filter {
      !$0.title.isEmpty
    }
    dataStore.save(tasks: tasks)
    closeWindow()

    NotificationCenter.default.post(
      name: .dataRefreshNeeded,
      object: nil
    )
  }

  func markAllTasksIncomplete() {
    for index in 0 ..< tasks.count {
      tasks[index].reset()
    }
  }
}
