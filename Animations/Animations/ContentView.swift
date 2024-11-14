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
    .blur(radius: (animationAmount - 1) * 3)
    .animation(
      .easeInOut(duration: 2)
      .repeatForever(autoreverses: true),
      value: animationAmount
    )
  }
}

#Preview {
  ContentView()
}
