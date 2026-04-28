//
//  NewTicketView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//
//  Denne visningen viser to ting:
//  1. Et skjema for å opprette en ny helpdesk-sak.
//  2. En liste over alle saker brukeren har registrert.
//  Data hentes fra og lagres til backend via APIService.swift.
//

import SwiftUI

struct NewTicketView: View {
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var ticketStore: TicketStore

    @State private var tittel = ""
    @State private var beskrivelse = ""
    @State private var kategori = "Programvare"
    @State private var prioritet = "Vanlig"
    @State private var melding = ""
    @State private var senderInn = false

    let kategorier = ["Programvare", "Maskinvare", "Nettverk", "Annet"]
    let prioriteter = ["Lav", "Vanlig", "Høy"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {

                    opprettSakSeksjon
                    sakliste
                    AppFooter()

                }
                .padding()
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Saker")
            .navigationBarTitleDisplayMode(.inline)
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
        // Last saker første gang fanen vises
        .task {
            if let token = authStore.token {
                await ticketStore.lastSaker(token: token)
            }
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Skjema for ny sak
    // -----------------------------------------------------------------------

    var opprettSakSeksjon: some View {
        AppKort {
            Text("Ny sak")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.primary)
                .accessibilityAddTraits(.isHeader)

            Text("Tittel")
                .font(.headline)
                .foregroundColor(AppTheme.textPrimary)

            TextField("Kort beskrivelse av problemet", text: $tittel)
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

            TextField("Beskriv problemet i detalj", text: $beskrivelse, axis: .vertical)
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
                ForEach(kategorier, id: \.self) { Text($0) }
            }
            .pickerStyle(.menu)
            .accessibilityLabel("Kategori")

            Text("Prioritet")
                .font(.headline)
                .foregroundColor(AppTheme.textPrimary)

            Picker("Velg prioritet", selection: $prioritet) {
                ForEach(prioriteter, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            .accessibilityLabel("Prioritet")

            if !melding.isEmpty {
                Text(melding)
                    .font(.body)
                    .foregroundColor(melding.contains("sendt") ? AppTheme.secondary : AppTheme.danger)
                    .accessibilityLabel(melding)
            }

            // Send-knapp med loading-indikator
            Button(action: sendInnSak) {
                if senderInn {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Send inn sak")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
            .disabled(senderInn)
            .accessibilityHint("Sender inn en ny sak til helpdesk")
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Saksliste
    // -----------------------------------------------------------------------

    @ViewBuilder
    var sakliste: some View {
        AppKort {
            HStack {
                Text("Dine saker")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTheme.primary)
                    .accessibilityAddTraits(.isHeader)

                Spacer()

                // Oppdater-knapp
                Button {
                    Task {
                        if let token = authStore.token {
                            await ticketStore.lastSaker(token: token)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(AppTheme.primary)
                }
                .accessibilityLabel("Oppdater saksliste")
            }

            if ticketStore.isLoading {
                ProgressView("Laster saker…")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)

            } else if let feil = ticketStore.feilmelding {
                Text(feil)
                    .foregroundColor(AppTheme.danger)
                    .font(.body)

            } else if ticketStore.saker.isEmpty {
                Text("Du har ingen saker registrert ennå.")
                    .foregroundColor(AppTheme.textSecondary)
                    .font(.body)
                    .padding(.vertical, 8)

            } else {
                ForEach(ticketStore.saker) { sak in
                    sakKort(sak: sak)
                }
            }
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Sakskort
    // -----------------------------------------------------------------------

    func sakKort(sak: Sak) -> some View {
        VStack(alignment: .leading, spacing: 8) {

            // Tittel + status-merke
            HStack {
                Text(sak.tittel)
                    .font(.headline)
                    .foregroundColor(AppTheme.textPrimary)
                Spacer()
                statusMerke(sak.status)
            }

            // Beskrivelse (maks 2 linjer)
            Text(sak.beskrivelse)
                .font(.body)
                .foregroundColor(AppTheme.textSecondary)
                .lineLimit(2)

            // Kategori, prioritet og dato
            HStack(spacing: 8) {
                merke(sak.kategori, farge: AppTheme.primary)
                merke(sak.prioritet, farge: AppTheme.secondary)
                Spacer()
                Text(sak.datoKort)
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }

            // Vis "Marker som løst"-knapp bare for åpne saker
            if !sak.erLost {
                Button("Marker som løst") {
                    Task {
                        if let token = authStore.token {
                            await ticketStore.markerLost(token: token, sakId: sak.id)
                        }
                    }
                }
                .font(.subheadline)
                .foregroundColor(AppTheme.secondary)
                .accessibilityHint("Markerer saken '\(sak.tittel)' som løst")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(AppTheme.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }

    /// Farget etikett (f.eks. kategori eller prioritet).
    func merke(_ tekst: String, farge: Color) -> some View {
        Text(tekst)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(farge.opacity(0.12))
            .foregroundColor(farge)
            .cornerRadius(6)
    }

    /// Statusmerke som viser "Åpen" eller "Løst".
    func statusMerke(_ status: String) -> some View {
        let farge: Color = status == "Løst" ? AppTheme.secondary : AppTheme.primary
        return Text(status)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(farge.opacity(0.15))
            .foregroundColor(farge)
            .cornerRadius(6)
    }

    // -----------------------------------------------------------------------
    // MARK: – Handlinger
    // -----------------------------------------------------------------------

    private func sendInnSak() {
        // Lokal validering
        guard !tittel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            melding = "Du må skrive inn en tittel."
            return
        }
        guard !beskrivelse.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            melding = "Du må skrive inn en beskrivelse."
            return
        }
        guard let token = authStore.token else {
            melding = "Du er ikke innlogget."
            return
        }

        senderInn = true
        melding = ""

        Task {
            if let feil = await ticketStore.opprettNySak(
                token: token,
                tittel: tittel,
                beskrivelse: beskrivelse,
                kategori: kategori,
                prioritet: prioritet
            ) {
                melding = feil
            } else {
                melding = "Saken er sendt inn."
                tittel = ""
                beskrivelse = ""
                kategori = "Programvare"
                prioritet = "Vanlig"
            }
            senderInn = false
        }
    }
}


