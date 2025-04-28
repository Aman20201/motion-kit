import SwiftUI

@available(iOS 13.0, *)
public struct ShakeButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    private let shakes: Int
    private let amplitude: CGFloat
    private let duration: Double

    @State private var progress: CGFloat = 0

    /// Creates a button that shakes/wobbles on tap.
    /// - Parameters:
    ///   - shakes: Number of shake cycles
    ///   - amplitude: Maximum horizontal displacement
    ///   - duration: Total duration of shake animation
    ///   - action: Action to perform when tapped
    ///   - label: ViewBuilder closure for button label
    public init(
        shakes: Int = 3,
        amplitude: CGFloat = 10,
        duration: Double = 0.5,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.shakes = shakes
        self.amplitude = amplitude
        self.duration = duration
        self.action = action
        self.label = label()
    }

    public var body: some View {
        Button(action: {
            // Trigger shake animation
            withAnimation(Animation.linear(duration: duration)) {
                progress = 1
            }
            // Reset progress after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                progress = 0
            }
            action()
        }) {
            label
        }
        .modifier(ShakeEffect(shakes: CGFloat(shakes),
                              amplitude: amplitude,
                              progress: progress))
    }
}

@available(iOS 13.0, *)
public struct ShakeEffect: GeometryEffect {
    /// Number of shake cycles
    public var shakes: CGFloat
    /// Maximum horizontal translation
    public var amplitude: CGFloat
    /// Animation progress from 0 to 1
    public var progress: CGFloat

    public var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = amplitude * sin(progress * .pi * 2 * shakes)
        let transform = CGAffineTransform(translationX: translation, y: 0)
        return ProjectionTransform(transform)
    }
} 