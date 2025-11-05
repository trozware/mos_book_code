//
// CommandRunner.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import Foundation
import Observation

@Observable class CommandRunner {
  var output: String = ""

  func runCommand(
    _ command: String,
    with arguments: [String] = []
  ) async -> String {
    publishOutput("> \(command) \(arguments.joined(separator: " "))\n\n")

    let process = Process()
    process.executableURL = URL(fileURLWithPath: command)
    process.arguments = arguments

    let outPipe = Pipe()
    let outFile = outPipe.fileHandleForReading
    process.standardOutput = outPipe

    do {
      try process.run()

      var returnValue = ""
      while process.isRunning {
        let newString = getAvailableData(from: outFile)
        publishOutput(newString)
        returnValue += newString
      }
      let newString = getAvailableData(from: outFile)
      publishOutput(newString + "\n")
      returnValue += newString

      return
        returnValue
        .trimmingCharacters(in: .whitespacesAndNewlines)
    } catch {
      print(error)
    }
    return ""
  }

  func pathTo(command: String) async -> String {
    await runCommand("/bin/zsh", with: ["-c", "which \(command)"])
  }

  func getAvailableData(from fileHandle: FileHandle) -> String {
    let newData = fileHandle.availableData
    if let string = String(data: newData, encoding: .utf8) {
      return string
    }
    return "-"
  }

  func publishOutput(_ text: String) {
    Task {
      await MainActor.run {
        self.output += text
      }
    }
  }

  func clearOutput() {
    output = ""
  }
}
