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

                        TextField("Skriv inn e-post", text: $email)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
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

                        SecureField("Skriv inn passord", text: $password)
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

                        SecureField("Skriv inn passord på nytt", text: $bekreftPassord)
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
                                .foregroundColor(melding.contains("ferdig") ? .green : .red)
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

                            let ok = authStore.register(email: email, password: password)

                            if ok {
                                melding = "Bruker opprettet ferdig. Du kan nå logge inn."
                                email = ""
                                password = ""
                                bekreftPassord = ""
                            } else {
                                melding = "Denne e-posten finnes allerede."
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
    }
}
