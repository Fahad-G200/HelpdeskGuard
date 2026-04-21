//
//  NewTicketView.swift
//  HelpdeskGuard
//
//  Skjema for å opprette en ny sak.
//  Saken sendes til backend via APIService.
//
//  Laget av Fahad – dette er skjemaet brukeren fyller ut når noe ikke virker. Enkelt og oversiktlig.
//

import SwiftUI

struct NewTicketView: View {

    @State private var tittel = ""
    @State private var beskrivelse = ""
    @State private var kategori = "Programvare"
    @State private var prioritet = "Vanlig"
    @State private var melding = ""
    @State private var sender = false

    let kategorier = ["Programvare", "Maskinvare", "Nettverk", "Annet"]
    let prioriteter = ["Lav", "Vanlig", "Høy"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ny sak")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primary)
                            .accessibilityAddTraits(.isHeader)

                        Text("Fyll ut skjemaet under for å registrere en ny sak.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    AppKort {
                        Text("Tittel")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        TextField("Skriv inn en kort tittel", text: $tittel)
                            .accessibilityLabel("Tittel")
                            .accessibilityHint("Skriv inn en kort tittel på saken")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(AppTheme.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )

                        Text("Beskrivelse")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        TextField("Beskriv problemet ditt", text: $beskrivelse, axis: .vertical)
                            .accessibilityLabel("Beskrivelse")
                            .accessibilityHint("Beskriv problemet så tydelig som mulig")
                            .lineLimit(4, reservesSpace: true)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(AppTheme.cornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )

                        Text("Kategori")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        Picker("Velg kategori", selection: $kategori) {
                            ForEach(kategorier, id: \.self) { k in
                                Text(k)
                            }
                        }
                        .pickerStyle(.menu)
                        .accessibilityLabel("Kategori")

                        Text("Prioritet")
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)

                        Picker("Velg prioritet", selection: $prioritet) {
                            ForEach(prioriteter, id: \.self) { p in
                                Text(p)
                            }
                        }
                        .pickerStyle(.segmented)
                        .accessibilityLabel("Prioritet")

                        if !melding.isEmpty {
                            Text(melding)
                                .font(.body)
                                .foregroundColor(melding.contains("sendt") ? AppTheme.secondary : AppTheme.danger)
                                .accessibilityLabel(melding)
                        }

                        Button(action: sendInnSak) {
                            if sender {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.white)
                            } else {
                                Text("Send inn sak")
                            }
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                        .disabled(sender)
                        .accessibilityHint("Sender inn saken")
                    }

                    AppFooter()
                }
                .padding()
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Ny sak")
            .navigationBarTitleDisplayMode(.inline)
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }

    // Validerer skjemaet og sender saken til backend
    private func sendInnSak() {
        let renTittel = tittel.trimmingCharacters(in: .whitespacesAndNewlines)
        let renBeskrivelse = beskrivelse.trimmingCharacters(in: .whitespacesAndNewlines)

        if renTittel.isEmpty {
            melding = "Du må skrive inn en tittel."
            return
        }
        if renBeskrivelse.isEmpty {
            melding = "Du må skrive inn en beskrivelse."
            return
        }

        sender = true
        melding = ""

        Task {
            do {
                try await APIService.shared.sendSak(
                    tittel: renTittel,
                    beskrivelse: renBeskrivelse,
                    kategori: kategori,
                    prioritet: prioritet
                )
                melding = "Saken er sendt inn ✓"
                tittel = ""
                beskrivelse = ""
                kategori = "Programvare"
                prioritet = "Vanlig"
            } catch let feil as APIFeil {
                melding = feil.errorDescription ?? "Noe gikk galt."
            } catch {
                melding = "Kunne ikke koble til serveren. Sjekk at backend kjører."
            }
            sender = false
        }
    }
}

