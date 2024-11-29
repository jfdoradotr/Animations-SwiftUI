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

## Animating Bindings

In SwiftUI, you can apply animations directly to bindings with the `.animation()` modifier, creating smooth transitions as values changes. This is particularly useful when adjusting values with controls like `Stepper` or `Slider`, where the animation adjusts dynamically based on user input.

### How Binding Animations Work

When you attach `.animation()` to a binding, SwiftUI animates any view properties linked to that binding as it transitions from the current to the new value.

This also works with data that doesn't traditionally "animate" smoothly, like booleans. SwiftUI interprets the change in state (e.g., from `true` to `false`) and animates the transition for properties that depend on that state.

### Basic Example: Animating a Scale with a Binding

Here's an example where `Stepper` and `Button` both modify the `animationAmount` value. The `.animation()` modifier is attached to the binding in `Stepper`, creating a smooth scale transition each time the value changes.

```swift
struct ContentView: View {
  @State private var animationAmount = 1.0

  var body: some View {
    VStack {
      Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

      Spacer()

      Button("Tap me") {
        animationAmount += 1
      }
      .padding(40)
      .background(.red)
      .foregroundStyle(.white)
      .clipShape(.circle)
      .scaleEffect(animationAmount)
    }
  }
}
```

- Explanation
  - The `Stepper` control animates smoothly because `.animation()` is applied to its binding. Each step increases `animationAmount` by 1, and the button's scale effect reflects this change.
  - However, pressing the button doesn't create the same smooth animation since `.animation()` is only attached to the `Stepper`'s binding, not the button action.

### Customizing the Animation

You can further customize the animation by specifying parameters inside the `.animation()` modifier, such as `duration`, `ease`, and `repeatCount`.

```swift
struct ContentView: View {
  @State private var animationAmount = 1.0

  var body: some View {
    VStack {
      Stepper(
        "Scale amount",
        value: $animationAmount
          .animation(
            .easeInOut(duration: 1)
            .repeatCount(3, autoreverses: true)
          ),
        in: 1...10
      )

      Spacer()

      Button("Tap me") {
        animationAmount += 1
      }
      .padding(40)
      .background(.red)
      .foregroundStyle(.white)
      .clipShape(.circle)
      .scaleEffect(animationAmount)
    }
  }
}
```

- Explanation
  - In this version, the animation applied to `Stepper` has a 1 second duration, repeats 3 times, and reverses on each repeat. Each time you tap the `Stepper`, SwiftUI animates the scale with these custom settings.

### Understanding Binding Animations

SwiftUI animations work by comparing the initial state to the final state. This is why you can animate boolean values: SwiftUI detects the change in state (e.g., `false` or `true`) and animates any visual changes associated with that state transition.

For instance:

- Animating between `false` and `true` could smoothly animate a view's opacity from 0 (invisible) to 1 (visible) if `opacity` is bound to a boolean state.

### Why Use `.animation()` on Bindings?

Using `.animation()` directly on bindings makes it easy to animate properties based on continuous changes in value. It eliminates the need to attach `.animation(.default, value:)` each time the value updates, resulting in cleaner code and smooth transitions.

### Summary

Binding animations in SwiftUI allow for smooth, automatic animations as data changes, with the ability to customize timing, delay, and repetition. This technique provides an effortless way to add life to UI elements like steppers and sliders and works with simple state transitions, even with boolean values.

## Creating Explicit Animations

**Explicit animations** in SwiftUI let you directly control how and when an animation occurs. Unlike implicit animations, which are tied to a binding or a modifier, explicit animations are triggered by a specific event or state change, giving you precise control.

### Key Features of Explicit Animations

1. **Triggered Manually**: Explicit animations are not automatically tied to a view or binding. Instead, they are invoked when you want them to occur.
2. **Uses `withAnimation`**: You wrap your state-change changing logic in the `withAnimation` block to apply an animation.
3. **Supports Customization**: You can pass animation types to `withAnimation` for full control over the behavior.

### Example 1: Basic Explicit Animation

Here's a simple example where tapping a button rotates it by 360 degrees along the Y-axis.

```swift
struct ContentView: View {
  @State private var animationAmount = 0.0

  var body: some View {
    Button("Tap Me") {
      withAnimation {
        animationAmount += 360
      }
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(Circle())
    .rotation3DEffect(
      .degrees(animationAmount), // Rotate based on animationAmount
      axis: (x: 0, y: 1, z: 0)  // Rotate along the Y-axis
    )
  }
}
```

- What's happening:
  - Tapping the button triggers the `withAnimation` block.
  - The state variable `animationAmount` increases by 360.
  - The change is animated, creating a smooth 3D rotation effect.

### Example 2: Rotating Along Different Axes

By modyfing the `axis` parameter in `rotation3DEffect`, you can rotate the button in different directions:

1. Rotate in X and Y:

    ```swift
    axis: (x: 1, y: 1, z: 0) // Diagonal rotation
    ```

2. Rotate in Z Only

    ```swift
    axis: (x: 0, y: 0, z: 1) // Flat rotation on the Z-axis
    ```

### Example 3: Customizing the Animation with Spring

The `withAnimation` block can accept different animation types. For instance, a **spring animation** adds a bounce effect to the rotation.

```swift
struct ContentView: View {
  @State private var animationAmount = 0.0

  var body: some View {
    Button("Tap Me") {
      withAnimation(.spring(duration: 1, bounce: 0.5)) {
        animationAmount += 360
      }
    }
    .padding(50)
    .background(.red)
    .foregroundStyle(.white)
    .clipShape(Circle())
    .rotation3DEffect(
      .degrees(animationAmount),
      axis: (x: 0, y: 1, z: 0)
    )
  }
}
```

- `spring(duration:bounce:)` Parameters:
  - `duration`: How long the animation lasts.
  - `bounce`: How much the element bounces back and forth. Values closer to `1` create more bounce, while values closer to `0` settle quickly.

---

### Why Use Explicit Animations?

- **Precise Control**: They are triggered intentionally, giving you full control over when and how animations occur.
- **Custom Effects**: With `withAnimation`, you can apply complex, dynamic animations such as spring or easing effects.
- **Event-Driven**: They are perfect for animations tied to specific user actions or events, like button taps or gesture direction.

---

### Summary

Explicit animations in SwiftUI:
- Use the `withAnimation` block to trigger animations manually.
- Allow full customization with animation types like `.spring` or `.easeInOut`.
- Work well for event-driven changes like rotations, scaling, or movement along specific axes.

By combining explicit animations with custom parameters, you can create engaging and highly interactive UI elements that respond dynamically to user interactions. Experiment with axes, spring animations, and durations to see the full potential of explicit animations in SwiftUI!.

## Controlling the Animation Stack

When working with animations in SwiftUI, the **order of modifiers** matters. Each animation affects only the properties of the view that are above it in the modifier stack. Understanding this order allows you to control which properties are animated and even apply different animations to specific properties.

### 1. Simple Animation Example

Here’s a simple animation that changes the background color of a button when a boolean state (`enabled`) toggles:

```swift
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
```

- What's happening:
  - When the button is tapped, the `enabled` state toggles between `true` and `false`.
  - The `.background` modifier updates its color based on `enabled`.
  - `.animation(.default, value: enabled)` animates the transition between red and blue smoothly.

### 2. Modifier Order Matters

The position of the `.animation` modifier in the stack determines which properties are animated. If you add a modifier after the `.animation` modifier, it won't be animated, even if it uses the same state.

#### Example: Modifier After `.animation`

```swift
@State private var enabled = false

var body: some View {
    Button("Tap Me") {
        enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .blue : .red)
    .foregroundStyle(.white)
    .animation(.default, value: enabled)
    .clipShape(.rect(cornerRadius: enabled ? 60 : 0)) // Not animated
}
```

- What's Happening:
  - The `.clipShape` modifier depends on the same `enabled` state, but since it's added after `.animation`, it's not animated.
  - The color change is animated, but the shape change is instant.

### 3. Fixing the Order

To animate the shape change, you need to move the `.clipShape` modifier **above** the `.animation` modifier.

```swift
@State private var enabled = false

var body: some View {
    Button("Tap Me") {
        enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .blue : .red)
    .foregroundStyle(.white)
    .clipShape(.rect(cornerRadius: enabled ? 60 : 0)) // Animated now
    .animation(.default, value: enabled)
}
```

- What's Happening:
  - Both the color transition and the shape change are now animated because `.clipShape` is part of the stack affected by `.animation`.

### 4. Applying Different Animations to Different Properties

You can add multiple `.animation` modifiers to customize the animations for different properties.
Each `.animation` modifier will affect only the properties above it in the stack.

```swift
@State private var enabled = false

var body: some View {
    Button("Tap Me") {
        enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .blue : .red)
    .foregroundStyle(.white)
    .animation(.default, value: enabled) // Smooth color transition
    .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
    .animation(.spring(duration: 1, bounce: 0.9), value: enabled) // Bouncy shape change
}
```

- What's happening:
  - The `.background` color transition uses `.default` animation for a smooth effect.
  - The `.clipShape` modifier uses a spring animation for a bouncy shape transition.

### Summary of Key Points

1. Modifier Order Matters:
   1. Animations only affect properties that are **above** the `.animation` modifier in the stack.
2. Multiple Animations:
   1. You can use `.animation` modifiers to apply different animations to different properties.
3. Fine Control:
   1. The animation stack gives you precise control over how each property is animated, allowing for dynamic and complex effects.
4. Experiment and Combine:
   1. By playing with animation types like `.default`, `.spring`, and `.easeInOut`, you can create unique animations tailored to your design needs.

With these tools, you can build rich, layered animations that bring your SwiftUI applications to life!


## Animating gestures

- This small code shows how we can move a view using gestures

  ```swift
  struct ContentView: View {
  @State private var dragAmount = CGSize.zero

  var body: some View {
    LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 300, height: 200)
      .clipShape(.rect(cornerRadius: 10))
      .offset(dragAmount)
      .gesture(
        DragGesture()
          .onChanged { dragAmount = $0.translation }
          .onEnded { _ in dragAmount = .zero }
      )
    }
  }
  ```

- Adding an animation of bouncing like this, will bounce the animation when we drag as well when it moves back to the original position

  ```swift
    var body: some View {
    LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 300, height: 200)
      .clipShape(.rect(cornerRadius: 10))
      .offset(dragAmount)
      .gesture(
        DragGesture()
          .onChanged { dragAmount = $0.translation }
          .onEnded { _ in dragAmount = .zero }
      )
      .animation(.bouncy, value: dragAmount)
  }
  ```

- As well we can animate specific values on specific parts of the gestures, for example in here we just animates when the gesture ends.

  ```swift
  struct ContentView: View {
  @State private var dragAmount = CGSize.zero

  var body: some View {
    LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 300, height: 200)
      .clipShape(.rect(cornerRadius: 10))
      .offset(dragAmount)
      .gesture(
        DragGesture()
          .onChanged { dragAmount = $0.translation }
          .onEnded { _ in
            withAnimation(.bouncy) {
              dragAmount = .zero
            }
          }
      )
    }
  }
  ```