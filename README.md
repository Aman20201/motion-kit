# MotionKit

A modern Swift package providing a suite of **UIKit** and **SwiftUI** animations and button effects for iOS developers. Whether you need basic view transformations or fancy interactive buttons, MotionKit has you covered with easy-to-use APIs.

---

## Features

### SwiftUI Buttons
- **LoadingButton** – integrated spinner overlay during async tasks.
- **ShakeButton** – error feedback with a quick shake.
- **GlowPulseButton** – soft glowing pulse effect.
- **HapticBounceButton** – button that springs with Core Haptics support on tap.

_(More effects and views coming soon!)_

---

## Installation

**Swift Package Manager**

1. In Xcode, choose **File → Swift Packages → Add Package Dependency...**
2. Enter the repository URL:
   ```
   https://github.com/your-username/MotionKit.git
   ```
3. Select the latest version and add to your target(s).

Or add to `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/your-username/MotionKit.git", from: "1.0.0"),
]
```

---

## Usage

### UIKit Example

```swift
import MotionKit

// Fade out
myView.fade(to: 0.0, duration: 0.5)

// Scale up
myView.scale(to: 1.5)

// Rotate
myView.rotate(to: .pi)

// Bounce
myView.bounce()
```

### SwiftUI Buttons Example

```swift
import SwiftUI
import MotionKit

struct ButtonsDemo: View {
  @State private var isLoading = false

  var body: some View {
    VStack(spacing: 20) {
      // Loading button
      LoadingButton(isLoading: $isLoading) {
        // simulate async work
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          isLoading = false
        }
      } label: {
        Text("Submit")
          .bold()
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.accentColor)
          .cornerRadius(8)
      }

      // Shake button
      ShakeButton(action: {
        print("Shake!")
      }) {
        Text("Error")
          .padding()
          .background(Color.red)
          .cornerRadius(6)
      }

      // Glow pulse
      GlowPulseButton(action: {}) {
        Text("Glow")
      }

      // Haptic bounce
      HapticBounceButton(action: {}) {
        Text("Tap Me")
      }
    }
    .padding()
  }
}
```

---

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to open a PR or issue on the GitHub repo.

---

## License

This project is released under the **MIT License**. See [LICENSE](LICENSE) for details. 