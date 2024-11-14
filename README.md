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

## Customizing Animations in SwiftUI

In SwiftUI, we can go beyond the default animation settings to create a wide range of effects, making animations feel natural, bouncy, delayed and even repeating indefinitely. Let's explore different ways to customize animations!

### 1. Basic Customization: Choosing the Animation type

Instead of using `.default`, we can customize the animation type to control how it behaves.

```swift
.animation(.linear, value: animationAmount)
```

Here, `.linear` creates an animation with a constant speed from start to finish. This results in a smooth, steady movement without any speed changes.

### 2. Spring Animation

A spring animation simulates a "bouncy" motion, as if the element is attached to a spring, It starts fast, slows down, then bounces a little before stopping, adding a natural feel to animations.

```swift
.animation(.spring(response: 1, dampingFracion: 0.5), value: animationAmount)
```

- `response`: Controls how long the spring animation takes to settle.
- `dampingFraction`: Controls how much bounce occurs. Values closer to 1 make it settle quickly, while values near 0 make it bounce more.

This example would create a bouncy effect, ideal for interactive elements like buttons.

### 3. EaseInOut Animation

The `.easeInOut` animation starts slow, speeds up in the middle, and slows down again at the end, giving a smooth, natural flow to the animation.

```swift
.animation(.easeInOut(duration: 2), value: animationAmount)
```

- `duration`: Controls how long the animation lasts, in seconds

This type of animation is perfect for transitions, as it adds an elegant feel by smoothly easing in and out.

### 4. Adding a Delay

Adding a delay lets us control when an animation starts after an action is triggered. This can be useful for creating sequences of animations.

```swift
.animation(
    .easeInOut(duration: 2)
    .delay(1),
    value: animationAmount
)
```

Here, the animation will wait 1 second after the button is tapped before starting the ease-in-out effect.

### 5. Repeating Animations

SwiftUI allows us to repeat animations a specific number of times or indefinitely, which can create dynamic and engagin effects.

- **Repeat a set number of times**

  ```swift
  .animation(
    .easeInOut(duration: 2)
    .repeatCount(3, autoreverses: true),
    value: animationAmount
  )
  ```

  - `repeatCount(3, autoreverse: true)`: Repeats the animation 3 times, reversing direction each time.

If you set `repeatCount(2, autoreverses: true)`, the animation will bounce twice and then quickly reset because it doesn't have a third repetition to balance the effect. This can create an abrupt finish.

- **Repeat indefinitely**

  ```swift
  .animation(
    .easeInOut(duration: 2)
    .repeatForever(autoreverses: true),
    value: animationAmount
  )
  ```

  - `repeatForever(autoreverses: true)`: The animation repeats forever, reversing each time.

This is useful for continuous animations, like a pulsing or rotating effect.

### 6. Creating a Ring Animation

With all the customization we've learned, we can create a beautiful "ring" animation that makes it look like a ripple is spreading out from a button. This uses a combination of `scaleEffect`, `opacity`, and `repeatForever`.

```swift
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
        .stroke(.red) // creates a ring outline
        .scaleEffect(animationAmount) // scale based on state
        .opacity(2 - animationAmount) // fades out as it scales up
        .animation(
          .easeInOut(duration: 1)
          .repeatForever(autoreverses: false),
          value: animationAmount
        )
    )
    .onAppear {
      animationAmount = 2 // triggers the animation
    }
  }
}
```

Here's what happening:

- **scaleEffect(animationAmount)** makes the ring grow from the button's center.
- **opacity(2 - animationAmount)** gradually fades the ring out as it expands
- **repeatForever(autoreverses: false)** causes the animation to repeat without reversing, creating a continuous outward motion.

The ring animation creates a subtle, continuous ripple effect.

### Summary

With these animation customizations, you can:

- **Control Speed** with `.linear` or `.easeInOut`
- **Add Bounce** with `.spring`.
- **Add Delays** for staggered animations.
- **Repeat Animations** a set number of times or indefinitely.

Custom animations in SwiftUI allow for creativity and polish, making your app's UI feel more dynamic and engaging. Experiment with these options to find the perfect animation for your design.
