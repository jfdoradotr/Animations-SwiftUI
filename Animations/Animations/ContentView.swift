//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var enabled = false

  var body: some View {
    Button("Tap Me") {
      enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .blue : .red)
    .foregroundStyle(.white)
    .animation(.default, value: enabled)
  }
}

#Preview {
  ContentView()
}
