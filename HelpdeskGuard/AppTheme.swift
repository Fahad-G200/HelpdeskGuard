//
//  AppTheme.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 23/03/2026.
//

import SwiftUI
import UIKit

struct AppTheme {
    static let primary = Color(red: 0.0, green: 0.24, blue: 0.55)
    static let secondary = Color(red: 0.0, green: 0.50, blue: 0.20)
    static let accent = Color(red: 0.55, green: 0.23, blue: 0.0)
    static let danger = Color(red: 0.72, green: 0.0, blue: 0.0)
    static let background = Color(.systemGroupedBackground)
    static let cardBackground = Color.white
    static let textPrimary = Color.primary
    static let textSecondary = Color(red: 0.18, green: 0.18, blue: 0.18)

    static let cornerRadius: CGFloat = 16
    static let buttonHeight: CGFloat = 56
    static let spacing: CGFloat = 16
    static let largeSpacing: CGFloat = 24
}

struct StorKnapp: ButtonStyle {
    var bakgrunnsfarge: Color = AppTheme.primary

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                bakgrunnsfarge.opacity(configuration.isPressed ? 0.8 : 1.0)
            )
            .cornerRadius(AppTheme.cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .padding(.horizontal, 4)
    }
}

struct AppKort<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
    }
}

struct AppFooter: View {
    var body: some View {
        VStack(spacing: 6) {
            Divider()

            Text("© 2026 HelpdeskGuard")
                .font(.footnote)
                .foregroundColor(AppTheme.textSecondary)

            Text("Skoleprosjekt av Fahad")
                .font(.caption)
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
    }
}

struct AppInputField: UIViewRepresentable {
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .sentences
    var autocorrection: UITextAutocorrectionType = .default

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .label
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = autocapitalization
        textField.autocorrectionType = autocorrection
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged(_:)), for: .editingChanged)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.isSecureTextEntry = isSecure
        uiView.keyboardType = keyboardType
        uiView.autocapitalizationType = autocapitalization
        uiView.autocorrectionType = autocorrection
        uiView.font = UIFont.preferredFont(forTextStyle: .body)
        uiView.adjustsFontForContentSizeCategory = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        @objc func textChanged(_ sender: UITextField) {
            text = sender.text ?? ""
        }
    }
}

