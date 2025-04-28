import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct HapticBounceButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    @State private var isPressed = false

    /// Creates a button that bounces and triggers haptic feedback on tap.
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }

    public var body: some View {
        label
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(
                .interpolatingSpring(stiffness: 300, damping: 15),
                value: isPressed
            )
            .onTapGesture {
                // Trigger haptic feedback
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                // Bounce animation
                withAnimation {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        isPressed = false
                    }
                    // Perform action after bounce
                    action()
                }
            }
    }
} 