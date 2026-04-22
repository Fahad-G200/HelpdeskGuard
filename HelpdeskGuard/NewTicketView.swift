//
//  NewTicketView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct NewTicketView: View {
    @EnvironmentObject var ticketStore: TicketStore
    @Environment(\.dismiss) private var dismiss

    @State private var tittel = ""
    @State private var beskrivelse = ""
    @State private var kategori = "Programvare"
    @State private var prioritet = "Vanlig"
    @State private var melding = ""

    let kategorier = ["Programvare", "Maskinvare", "Nettverk", "Annet"]
    let prioriteter = ["Lav", "Vanlig", "Høy"]

    var body: some View {
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
                        ForEach(kategorier, id: \.self) { kategori in
                            Text(kategori)
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityLabel("Kategori")

                    Text("Prioritet")
                        .font(.headline)
                        .foregroundColor(AppTheme.textPrimary)

                    Picker("Velg prioritet", selection: $prioritet) {
                        ForEach(prioriteter, id: \.self) { prioritet in
                            Text(prioritet)
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

                        let wasSaved = ticketStore.addTicket(
                            title: tittel,
                            description: beskrivelse,
                            category: kategori,
                            priority: prioritet
                        )

                        if wasSaved {
                            melding = "Saken er sendt inn."
                            tittel = ""
                            beskrivelse = ""
                            kategori = "Programvare"
                            prioritet = "Vanlig"
                            dismiss()
                        } else {
                            melding = "Kunne ikke lagre saken."
                        }
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                    .accessibilityHint("Sender inn en ny sak")
                }

                AppFooter()
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}
