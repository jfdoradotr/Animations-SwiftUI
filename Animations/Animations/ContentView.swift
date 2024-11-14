//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var animationAmount = 1.0

  var body: some View {
    Button("Tap Me") {
      animationAmount += 1
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount)
    .animation(.default, value: animationAmount)
  }
}

#Preview {
  ContentView()
}
