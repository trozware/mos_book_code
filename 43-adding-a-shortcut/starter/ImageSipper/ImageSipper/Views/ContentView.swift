//
// ContentView.swift
// macOS by Tutorials
// Version 3.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
  @Environment(\.openWindow) var openWindow
  @Environment(\.dismissWindow) var dismissWindow
  @Environment(AppDelegate.self) var appDelegate: AppDelegate

  @State private var selectedTab = TabSelection.editImage
  @State private var outputWindowIsVisible = false

  var body: some View {
    VStack {
      TabView(selection: $selectedTab) {
        Tab(
          "Edit Image",
          systemImage: "pencil",
          value: TabSelection.editImage
        ) {
          ImageEditView(selectedTab: $selectedTab)
        }
        Tab(
          "Make Thumbnails",
          systemImage: "photo.fill.on.rectangle.fill",
          value: TabSelection.makeThumbs
        ) {
          ThumbsView(selectedTab: $selectedTab)
        }
      }
      .tabViewStyle(.grouped)
      .padding([.horizontal, .top])
      .frame(minWidth: 650, minHeight: 450)

      HStack {
        Spacer()
        Button {
          outputWindowIsVisible.toggle()
        } label: {
          Text(outputWindowIsVisible ? "Hide Terminal Output" : "Show Terminal Output")
        }
        .padding([.horizontal, .bottom])
        .padding(.top, 2)
      }
    }
    .onChange(of: outputWindowIsVisible) { _, newValue in
      if newValue {
        openWindow(id: Constants.terminalWindowID)
      } else {
        dismissWindow(id: Constants.terminalWindowID)
      }
      appDelegate.floatingWindowVisible = newValue
    }
    .onAppear {
      outputWindowIsVisible = appDelegate.floatingWindowVisible
    }
    .onChange(of: appDelegate.floatingWindowVisible) { _, newValue in
      outputWindowIsVisible = newValue
    }
  }
}

#Preview {
  ContentView()
    .environment(SipsRunner())
    .environment(AppDelegate())
}

enum TabSelection {
  case editImage
  case makeThumbs
}
