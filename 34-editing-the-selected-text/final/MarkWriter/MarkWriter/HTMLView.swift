//
// HTMLView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI
import WebKit

struct HTMLView: View {
  @State private var page = WebPage()

  var html: String?
  var address: String?

  @AppStorage("styleSheet") var styleSheet: StyleSheet = .default

  var body: some View {
    WebView(page)
      .onAppear(perform: updatePage)
      .onChange(of: html) {
        updatePage()
      }
      .onChange(of: styleSheet) {
        updatePage()
      }
  }

  func updatePage() {
    if html != nil {
      let baseURL = Bundle.main.resourceURL!
      page.load(html: formattedHtml, baseURL: baseURL)
    } else if let address, let url = URL(string: address) {
      let request = URLRequest(url: url)
      page.load(request)
    }
  }

  var formattedHtml: String {
    var styleLink = ""
    if styleSheet != .default {
      styleLink = """
        <link href="\(styleSheet).css" rel="stylesheet">
        """
    }

    return """
      <html>
      <head>
        \(styleLink)
      </head>
      <body>
        \(html ?? "")
      </body>
      </html>
      """
  }
}

#Preview {
  HTMLView(html: "<h1>Hello, World!</h1>")
}
