//
// TaskView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import Cocoa

class TaskView: NSView {
  var task: Task?

  var imageView: NSImageView
  var titleLabel: NSTextField
  var infoLabel: NSTextField
  var progressBar: NSProgressIndicator

  override init(frame frameRect: NSRect) {
    // set up subviews

    titleLabel = NSTextField(frame: titleFrame)
    titleLabel.backgroundColor = .clear
    titleLabel.isBezeled = false
    titleLabel.isEditable = false
    titleLabel.font = NSFont.systemFont(ofSize: 14)
    titleLabel.lineBreakMode = .byTruncatingTail

    infoLabel = NSTextField(frame: infoProgressFrame)
    infoLabel.backgroundColor = .clear
    infoLabel.isBezeled = false
    infoLabel.isEditable = false
    infoLabel.font = NSFont.systemFont(ofSize: 11)

    super.init(frame: frameRect)

    // add subviews
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)

    if let task {
      // view update code
    }
  }
}
