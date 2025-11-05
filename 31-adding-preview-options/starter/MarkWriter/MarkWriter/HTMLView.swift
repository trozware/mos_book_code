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
  let html: String

  var body: some View {
    WebView(page)
      .onAppear(perform: updatePage)
      .onChange(of: html) {
        updatePage()
      }
  }

  func updatePage() {
    let baseURL = Bundle.main.resourceURL!
    page.load(html: html, baseURL: baseURL)
  }
}

#Preview {
  HTMLView(html: "<h1>Hello, World!</h1>")
}
