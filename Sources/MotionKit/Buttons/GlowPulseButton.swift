import SwiftUI

@available(iOS 13.0, *)
public struct GlowPulseButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    /// The color of the glowing pulse
    private let glowColor: Color
    /// The fill color of the button background
    private let backgroundColor: Color
    @State private var isPulsing: Bool = false

    /// Creates a button that pulses a glow and scale effect.
    /// - Parameters:
    ///   - action: The tap action callback
    ///   - glowColor: The color of the glow and shadow
    ///   - backgroundColor: The fill color of the button background
    ///   - label: The label view builder
    public init(action: @escaping () -> Void,
                glowColor: Color = .accentColor,
                backgroundColor: Color = .accentColor,
                @ViewBuilder label: () -> Label) {
        self.action = action
        self.glowColor = glowColor
        self.backgroundColor = backgroundColor
        self.label = label()
    }

    public var body: some View {
        Button(action: action) {
            label
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .scaleEffect(isPulsing ? 1.05 : 1.0)
        .shadow(color: glowColor.opacity(isPulsing ? 0.8 : 0.4),
                radius: isPulsing ? 20 : 5)
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 1.2)
                    .repeatForever(autoreverses: true)
            ) {
                isPulsing = true
            }
        }
    }
} 