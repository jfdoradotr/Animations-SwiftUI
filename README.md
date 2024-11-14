# Animations

## Implicit animations

SwiftUI makes it easy to add animations to your app with **implicit animations**. These animations automatically adjust any changes in state that affect views, animating the transition smoothly without extra configuration.

### Without Animation

In the code below, pressing the button increases `animationAmount`, which scales up the button, but the change happens instantly.

```swift
@State private var animationAmount = 1.0

  var body: some View {
    Button("Tap Me") {
      animationAmount += 1
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount) // Instant scaling change
  }
```

### Adding Animation

By adding `.animation(.default, value: animationAmount)`, you tell SwiftUI to smoothly animate any view properties that change as a result of `animationAmount` updates. Now, when the button is tapped, it scales up with a smooth animation.

```swift
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
    .animation(.default, value: animationAmount) // Adds smooth scaling animation
  }
}
```

### Animating Multiple Effects

SwiftUI's implicit animations affect any property tied to `animationAmount`.
Below, not only does the button scale up, but it also adds a blur effect that increases with each tap, creating a combined animation.

```swift
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
    .blur(radius: (animationAmount - 1) * 3) // Adds a blur effect
    .animation(.default, value: animationAmount)
  }
}
```

### Key Points of Implicit Animations

- **Automatic Transitions**: SwiftUI automatically animates changes tied to state variables, handling frames and transitions smoothly.
- **Multiple Properties**: All properties linked to the state variable are animated together.
- **No Manual Frame Updates**: SwiftUI manages frame updates as part of its declarative approach, so you don't need to specify frames or which specific properties to animate.

With implicit animations, SwiftUI simplifies adding smooth transitions and animations, making your app's UI feel more dynamic and interactive with minial code.