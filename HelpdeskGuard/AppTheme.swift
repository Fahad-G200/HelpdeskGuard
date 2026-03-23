//
//  AppTheme.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 23/03/2026.
//

import SwiftUI

struct AppTheme {
    static let primary = Color.blue
    static let secondary = Color.green
    static let accent = Color.orange
    static let background = Color(.systemGroupedBackground)
    static let cardBackground = Color.white
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary

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
            .frame(maxWidth: .infinity)
            .frame(height: AppTheme.buttonHeight)
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
