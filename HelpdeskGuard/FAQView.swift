//
//  FAQView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 22/04/2026.
//

import SwiftUI

// FAQView viser vanlige spørsmål og svar – dekker kompetansemålet om brukerveiledning
struct FAQView: View {

    // Liste med spørsmål og svar
    let sporsmalOgSvar: [(sporsmal: String, svar: String)] = [
        (
            "Hva er HelpdeskGuard?",
            "HelpdeskGuard er en enkel helpdesk-app for å registrere IT-problemer på skolen. Du kan opprette saker, se status og administrere kontoen din."
        ),
        (
            "Hvordan oppretter jeg en ny sak?",
            "Gå til Saker-fanen og trykk på '+ Ny sak'. Fyll ut tittel, beskrivelse, kategori og prioritet. Trykk deretter 'Send inn sak'."
        ),
        (
            "Hva skjer med dataene mine?",
            "All data lagres lokalt på din enhet. Ingenting sendes til internett. Du kan slette brukeren din og alle data fra Konto-fanen."
        ),
        (
            "Er passordet mitt trygt?",
            "Ja. Passordet ditt hashes med SHA-256 før det lagres, og innlogget bruker lagres i Keychain. Passordet kan aldri leses tilbake."
        ),
        (
            "Kan jeg slette en sak?",
            "Ja. I sakslisten kan du sveipe til venstre på en sak for å slette den."
        ),
        (
            "Hva betyr 'Prioritet'?",
            "Prioritet viser hvor viktig saken er. Lav = ikke hast. Vanlig = normal. Høy = haster."
        ),
        (
            "Kan jeg markere en sak som løst?",
            "Ja. Trykk på 'Marker som løst' på en sak i listen. Du kan også åpne den igjen ved å trykke 'Marker som åpen'."
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {

                Text("Spørsmål og svar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primary)
                    .accessibilityAddTraits(.isHeader)

                Text("Her finner du svar på de vanligste spørsmålene om HelpdeskGuard.")
                    .font(.body)
                    .foregroundColor(AppTheme.textPrimary)

                ForEach(sporsmalOgSvar, id: \.sporsmal) { element in
                    AppKort {
                        Text(element.sporsmal)
                            .font(.headline)
                            .foregroundColor(AppTheme.primary)
                            .accessibilityAddTraits(.isHeader)

                        Text(element.svar)
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }
                }

                AppFooter()
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("FAQ")
        .navigationBarTitleDisplayMode(.inline)
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}
