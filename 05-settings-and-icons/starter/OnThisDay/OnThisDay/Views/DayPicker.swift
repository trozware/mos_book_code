//
// DayPicker.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI

struct DayPicker: View {
  @Environment(AppState.self) var appState: AppState

  @SceneStorage("selectedDate") var selectedDate: String?

  @State private var month = "January"
  @State private var day = 1

  var maxDays: Int {
    switch month {
      case "February":
        return 29
      case "April", "June", "September", "November":
        return 30
      default:
        return 31
    }
  }

  var body: some View {
    VStack {
      Text("Select a Date")

      HStack {
        Picker("", selection: $month) {
          ForEach(appState.englishMonthNames, id: \.self) {
            Text($0)
          }
        }

        Picker("", selection: $day) {
          ForEach(1 ... maxDays, id: \.self) {
            Text("\($0)")
          }
        }
        .frame(maxWidth: 60)
        .padding(.trailing, 8)
      }
      .pickerStyle(.menu)

      if appState.isLoading {
        ProgressView()
          .frame(height: 28)
      } else {
        Button("Get Events") {
          Task {
            await getNewEvents()
          }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
      }
    }
    .padding(.bottom, 8)
  }

  func getNewEvents() async {
    let monthIndex = appState.englishMonthNames
      .firstIndex(of: month) ?? 0
    let monthNumber = monthIndex + 1
    await appState.getDataFor(month: monthNumber, day: day)
    selectedDate = "\(month) \(day)"
  }
}

#Preview {
  DayPicker()
    .environment(AppState())
    .frame(width: 200)
}
