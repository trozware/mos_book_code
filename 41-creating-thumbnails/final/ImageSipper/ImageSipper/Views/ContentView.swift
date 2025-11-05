//
// ContentView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ContentView: View {
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
  }
}

#Preview {
  ContentView()
    .environment(SipsRunner())
}

enum TabSelection {
  case editImage
  case makeThumbs
}
