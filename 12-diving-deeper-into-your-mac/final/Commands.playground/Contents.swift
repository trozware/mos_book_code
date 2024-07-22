//
// Commands.playground
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import Foundation

func getAvailableData(from fileHandle: FileHandle) -> String {
  let newData = fileHandle.availableData
  if let string = String(data: newData, encoding: .utf8) {
    return string
  }
  return ""
}

func runCommand(
  _ command: String,
  with arguments: [String] = []
) async -> String {
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
      returnValue += newString
    }
    let newString = getAvailableData(from: outFile)
    returnValue += newString

    return returnValue
      .trimmingCharacters(in: .whitespacesAndNewlines)
  } catch {
    print(error)
  }

  return ""
}

func pathTo(command: String) async -> String {
  await runCommand("/bin/zsh", with: ["-c", "which \(command)"])
}

//  Task {
//    let commandPath = await pathTo(command: "cal")
//    let cal = await runCommand(commandPath, with: ["-h"])
//    print(cal)
//  }

// TODO: Edit these file paths before running the playground

let imagePath = "/path/to/folder/rosella.png"
let imagePathSmall = "/path/to/folder/rosella_small.png"

Task {
  let sipsPath = await pathTo(command: "sips")

  let args = ["--getProperty", "all", imagePath]
  let imageData = await runCommand(sipsPath, with: args)
  print(imageData)

  let resizeArgs = [
    "--resampleWidth", "800",
    imagePath,
    "--out", imagePathSmall
  ]

  let output = await runCommand(sipsPath, with: resizeArgs)
  print("Output: \(output)")
}
