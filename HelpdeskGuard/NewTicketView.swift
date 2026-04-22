//
//  NewTicketView.swift
//  HelpdeskGuard
//
//  Oppdatert for backend-integrasjon via API.swift og TicketStore.
//

import SwiftUI

struct NewTicketView: View {
    @EnvironmentObject var ticketStore: TicketStore
    @EnvironmentObject var authStore: AuthStore

    @State private var tittel = ""
    @State private var beskrivelse = ""
    @State private var kategori = "Programvare"
    @State private var prioritet = "Vanlig"
    @State private var melding = ""

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

                        Button("Send inn sak") {
                            if tittel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                melding = "Du må skrive inn en tittel."
                                return
                            }

                            if beskrivelse.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                melding = "Du må skrive inn en beskrivelse."
                                return
                            }

                            // Task lar oss kalle async-funksjoner fra en knapp
                            Task {
                                // Hent token fra AuthStore (kan være nil hvis lokal modus)
                                let token = authStore.jwtToken ?? ""
                                let ok = await ticketStore.addTicket(
                                    token: token,
                                    tittel: tittel,
                                    beskrivelse: beskrivelse,
                                    kategori: kategori,
                                    prioritet: prioritet
                                )

                                if ok {
                                    melding = "Saken er sendt inn."
                                    tittel = ""
                                    beskrivelse = ""
                                    kategori = "Programvare"
                                    prioritet = "Vanlig"
                                } else {
                                    melding = "Feil: kunne ikke sende sak. Sjekk at serveren kjører."
                                }
                            }
                        }
                        .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                        .accessibilityHint("Sender inn en ny sak")

                        // Vis saker fra backend
                        if !ticketStore.tickets.isEmpty {
                            Text("Registrerte saker")
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)

                            ForEach(ticketStore.tickets) { sak in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(sak.tittel)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(AppTheme.textPrimary)

                                    Text("\(sak.kategori) · \(sak.prioritet) · \(sak.status)")
                                        .font(.caption)
                                        .foregroundColor(AppTheme.textSecondary)

                                    Text(sak.opprettet)
                                        .font(.caption2)
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(AppTheme.cornerRadius)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }
                    }

                    AppFooter()
                }
                .padding()
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Ny sak")
            .navigationBarTitleDisplayMode(.inline)
            // Last inn saker fra backend når siden åpnes
            .task {
                if let token = authStore.jwtToken {
                    await ticketStore.lastSaker(token: token)
                }
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}

