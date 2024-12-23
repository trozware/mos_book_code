//
// WebView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
  let html: String?
  let address: String?

  @AppStorage("styleSheet") var styleSheet: StyleSheet = .github

  init(html: String?, address: String? = nil) {
    self.html = html
    self.address = address
  }

  func makeNSView(context: Context) -> WKWebView {
    WKWebView()
  }

  func updateNSView(_ nsView: WKWebView, context: Context) {
    if html != nil {
      nsView.loadHTMLString(
        formattedHtml,
        baseURL: Bundle.main.resourceURL
      )
    } else if let address, let url = URL(string: address) {
      let request = URLRequest(url: url)
      nsView.load(request)
    }
  }

  var formattedHtml: String {
    return """
      <html>
      <head>
        <link href="\(styleSheet).css" rel="stylesheet">
      </head>
      <body>
        \(html ?? "")
      </body>
      </html>
      """
  }
}
