//
// Constants.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

enum Constants {
  static let terminalWindowID = "terminal_output"
  static let terminalTextID = "terminal_text"
}

extension Notification.Name {
  static let serviceReceivedImage = Notification.Name("serviceReceivedImage")
  static let serviceReceivedFolder = Notification.Name("serviceReceivedFolder")
}
