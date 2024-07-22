//
// EditTasksView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct EditTasksView: View {
  @State private var dataStore = DataStore()
  @State private var tasks: [Task] = []

  var body: some View {
    VStack {
      ForEach($tasks) { $task in
        HStack(spacing: 20) {
          TextField(
            "",
            text: $task.title,
            prompt: Text("Task title")
          )
          .textFieldStyle(.squareBorder)

          Image(
            systemName: task.status == .complete
            ? "checkmark.square"
            : "square"
          )
          .font(.title2)

          Button {
            deleteTask(id: task.id)
          } label: {
            Image(systemName: "trash")
          }
        }
      }
      .padding(.top, 12)
      .padding(.horizontal)

      Spacer()

      EditButtonsView(tasks: $tasks, dataStore: dataStore)
    }
    .frame(minWidth: 400, minHeight: 430)
    .onAppear {
      getTaskList()
    }
  }

  func getTaskList() {
    tasks = dataStore.readTasks()
    addEmptyTasks()
  }

  func addEmptyTasks() {
    while tasks.count < 10 {
      tasks.append(Task(id: UUID(), title: ""))
    }
  }

  func deleteTask(id: UUID) {
    let taskIndex = tasks.firstIndex {
      $0.id == id
    }

    if let taskIndex {
      tasks.remove(at: taskIndex)
      addEmptyTasks()
    }
  }
}

#Preview {
  EditTasksView()
    .frame(width: 400, height: 430)
}

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
