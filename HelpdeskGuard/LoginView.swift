//
//  LoginView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 16/03/2026.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authStore: AuthStore

    @State private var email = ""
    @State private var password = ""
    @State private var feilmelding = ""
    @State private var visRegistrering = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Logg inn")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primary)
                            .accessibilityAddTraits(.isHeader)

                        Text("Logg inn for å bruke HelpdeskGuard og registrere saker.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    AppKort {
                        Text("E-post")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)


                        AppInputField(
                            text: $email,
                            placeholder: "Skriv inn e-post",
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
                            placeholder: "Skriv inn passord",
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

                        if !feilmelding.isEmpty {
                            Text(feilmelding)
                                .font(.body)
                                .foregroundColor(AppTheme.danger)
                                .accessibilityLabel("Feil. \(feilmelding)")
                        }

                        Button("Logg inn") {
                            Task {
                                do {
                                    let epost = try await APIService.shared.logginn(
                                        epost: email,
                                        passord: password
                                    )
                                    authStore.loggInn(epost: epost)
                                    feilmelding = ""
                                } catch let feil as APIFeil {
                                    feilmelding = feil.errorDescription ?? "Noe gikk galt."
                                } catch {
                                    feilmelding = "Kunne ikke koble til serveren. Sjekk at backend kjører."
                                }
                            }
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                        .accessibilityHint("Logger inn brukeren")

                        Button("Har du ikke konto? Registrer deg") {
                            visRegistrering = true
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.secondary))
                        .accessibilityHint("Åpner registreringssiden")
                    }

                    AppFooter()
                }
                .padding()
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Innlogging")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $visRegistrering) {
                RegisterView()
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}

