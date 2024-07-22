//
// WebView.swift
// macOS by Tutorials
// Version 2.0
//
// by Sarah Reichelt
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
  var html: String

  func makeNSView(context: Context) -> WKWebView {
    WKWebView()
  }

  func updateNSView(_ nsView: WKWebView, context: Context) {
    nsView.loadHTMLString(
      html,
      baseURL: Bundle.main.resourceURL
    )
  }
}
