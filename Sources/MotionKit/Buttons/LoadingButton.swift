import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct LoadingButton<Label: View>: View {
    /// Bindable loading state
    @Binding public var isLoading: Bool
    /// The UIActivityIndicator style for the spinner
    private let spinnerStyle: UIActivityIndicatorView.Style
    /// Action to perform
    private let action: () -> Void
    /// The button label
    private let label: () -> Label

    /// Creates a loading button.
    /// - Parameters:
    ///   - isLoading: Binding to loading state. When `true`, shows spinner and disables tap.
    ///   - spinnerStyle: The style of the built-in activity indicator (e.g. .medium, .large).
    ///   - action: Action to run when tapped (only when not loading).
    ///   - label: A view builder for the button label.
    public init(
        isLoading: Binding<Bool>,
        spinnerStyle: UIActivityIndicatorView.Style = .medium,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._isLoading = isLoading
        self.spinnerStyle = spinnerStyle
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(action: {
            if !isLoading {
                action()
            }
        }) {
            ZStack {
                // Hide label when loading
                label()
                    .opacity(isLoading ? 0 : 1)

                // Centered spinner
                if isLoading {
                    ActivityIndicator(isAnimating: $isLoading, style: spinnerStyle)
                }
            }
        }
        .disabled(isLoading)
        // Animate opacity change
        .animation(.easeInOut, value: isLoading)
    }
}

@available(iOS 13.0, *)
struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.hidesWhenStopped = true
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
} 