//
// TaskTimes.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Foundation

enum TaskTimes {
  #if DEBUG
    // in debug mode, shorten all the times to make testing faster
    static let taskTime: TimeInterval = 15
    static let shortBreakTime: TimeInterval = 5
    static let longBreakTime: TimeInterval = 20
  #else
    static let taskTime: TimeInterval = 25 * 60
    static let shortBreakTime: TimeInterval = 5 * 60
    static let longBreakTime: TimeInterval = 30 * 60
  #endif
}
