//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var animationAmount = 1.0

  var body: some View {
    Button("Tap Me") {
      // do nothing
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(Circle())
    .overlay(
      Circle()
        .stroke(.red)
        .scaleEffect(animationAmount)
        .opacity(2 - animationAmount)
        .animation(
          .easeInOut(duration: 1)
          .repeatForever(autoreverses: false),
          value: animationAmount
        )
    )
    .onAppear {
      animationAmount = 2
    }
  }
}

#Preview {
  ContentView()
}
