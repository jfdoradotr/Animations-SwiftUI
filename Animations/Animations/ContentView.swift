//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
  let amount: Double
  let anchor: UnitPoint

  func body(content: Content) -> some View {
    content
      .rotationEffect(.degrees(amount), anchor: anchor)
      .clipped()
  }
}

struct ContentView: View {
  @State private var isShowingRed = false

  var body: some View {
    VStack {
      Button("Tap Me") {
        withAnimation {
          isShowingRed.toggle()
        }
      }

      if isShowingRed {
        Rectangle()
          .fill(.red)
          .frame(width: 200, height: 200)
          .transition(.asymmetric(insertion: .scale, removal: .opacity))
      }
    }
  }
}

#Preview {
  ContentView()
}
