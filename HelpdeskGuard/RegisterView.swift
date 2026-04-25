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
                                .foregroundColor(melding.contains("ferdig") ? AppTheme.secondary : AppTheme.danger)
                                .accessibilityLabel(melding)
                        }

                        Button("Opprett bruker") {
                            if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                melding = "Du må skrive inn e-post."
                                return
                            }

                            if password.isEmpty {
                                melding = "Du må skrive inn passord."
                                return
                            }

                            if password != bekreftPassord {
                                melding = "Passordene er ikke like."
                                return
                            }

                            Task {
                                do {
                                    try await APIService.shared.registrer(
                                        epost: email,
                                        passord: password
                                    )
                                    melding = "Bruker opprettet ferdig. Du kan nå logge inn."
                                    email = ""
                                    password = ""
                                    bekreftPassord = ""
                                } catch let feil as APIFeil {
                                    melding = feil.errorDescription ?? "Noe gikk galt."
                                } catch {
                                    melding = "Kunne ikke koble til serveren. Sjekk at backend kjører."
                                }
                            }
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                        .accessibilityHint("Oppretter en ny bruker")

                        Button("Lukk") {
                            dismiss()
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.secondary))
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
}
