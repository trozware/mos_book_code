//
// ShowView.swift
// macOS Apps Step by Step
// Version 4.0
//
// by Sarah Reichelt
//

import SwiftUI

struct ShowView: View {
  @AppStorage("showBirths") var showBirths = true
  @AppStorage("showDeaths") var showDeaths = true
  @AppStorage("showTotals") var showTotals = true

  var body: some View {
    VStack(alignment: .leading) {
      Toggle("Show Births", isOn: $showBirths)
      Toggle("Show Deaths", isOn: $showDeaths)
      Toggle("Show Totals", isOn: $showTotals)
    }
  }
}
