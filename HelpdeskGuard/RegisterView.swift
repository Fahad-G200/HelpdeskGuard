//
//  RegisterView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authStore: AuthStore
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var bekreftPassord = ""
    @State private var melding = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Registrer bruker")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primary)
                            .accessibilityAddTraits(.isHeader)

                        Text("Opprett en konto for å bruke HelpdeskGuard.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    AppKort {
                        Text("E-post")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        AppInputField(
                            text: $email,
                            isSecure: false,
                            keyboardType: .emailAddress,
                            autocapitalization: .none,
                            autocorrection: .no
                        )
                            .accessibilityLabel("E-post")
                            .accessibilityHint("Skriv inn e-postadressen din")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(AppTheme.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )

                        Text("Passord")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        AppInputField(
                            text: $password,
                            isSecure: true,
                            keyboardType: .default,
                            autocapitalization: .none,
                            autocorrection: .no
                        )
                            .accessibilityLabel("Passord")
                            .accessibilityHint("Skriv inn passordet ditt")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(AppTheme.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )

                        Text("Bekreft passord")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        AppInputField(
                            text: $bekreftPassord,
                            isSecure: true,
                            keyboardType: .default,
                            autocapitalization: .none,
                            autocorrection: .no
                        )
                            .accessibilityLabel("Bekreft passord")
                            .accessibilityHint("Skriv inn passordet på nytt")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(AppTheme.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )

                        if !melding.isEmpty {
                            Text(melding)
                                .font(.body)
                                .foregroundColor(melding.contains("innlogget") ? AppTheme.secondary : AppTheme.danger)
                                .accessibilityLabel(melding)
                        }

                        // Registreringsknapp – viser spinner mens vi venter på svar fra server
                        Button(action: registrer) {
                            if authStore.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("Opprett bruker")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                        .disabled(authStore.isLoading)
                        .accessibilityHint("Oppretter en ny bruker")

                        Button("Lukk") {
                            dismiss()
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.secondary))
                        .disabled(authStore.isLoading)
                        .accessibilityHint("Lukker registreringssiden")
                    }

                    AppFooter()
                }
                .padding()
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Registrering")
            .navigationBarTitleDisplayMode(.inline)
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }

    // -----------------------------------------------------------------------
    // MARK: – Handlinger
    // -----------------------------------------------------------------------

    private func registrer() {
        // Lokal validering før vi sender noe til serveren
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            melding = "Du må skrive inn e-post."
            return
        }
        guard !password.isEmpty else {
            melding = "Du må skrive inn passord."
            return
        }
        guard password == bekreftPassord else {
            melding = "Passordene er ikke like."
            return
        }

        melding = ""
        Task {
            if let feil = await authStore.registrer(epost: email, passord: password) {
                melding = feil
            }
            // Ved suksess setter AuthStore isLoggedIn = true,
            // og appen bytter automatisk til hoved-visningen.
        }
    }
}

