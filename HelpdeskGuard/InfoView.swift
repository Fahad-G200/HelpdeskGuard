//
//  InfoView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 23/03/2026.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                Text("Informasjon og personvern")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primary)
                    .accessibilityAddTraits(.isHeader)

                Text("Her kan du lese om hva appen lagrer, hvordan informasjon brukes, og hvilke regler som gjelder for bruk av HelpdeskGuard.")
                    .font(.body)
                    .foregroundColor(AppTheme.textPrimary)

                AppKort {
                    Text("Hva som lagres")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.primary)
                        .accessibilityAddTraits(.isHeader)

                    Text("Appen lagrer e-postadresse og passord for brukeren lokalt på enheten. Appen kan også lagre saker som brukeren oppretter i appen.")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)

                    Text("Dette er en enkel versjon 1.0 av prosjektet. Det brukes ikke avanserte skytjenester i denne versjonen.")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)
                }

                AppKort {
                    Text("Hvordan informasjon brukes")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.secondary)
                        .accessibilityAddTraits(.isHeader)

                    Text("Informasjonen brukes for å la brukeren logge inn, bruke appen og registrere saker. Opplysningene brukes bare i appens funksjoner og ikke til reklame eller sporing.")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)
                }

                AppKort {
                    Text("Regler for bruk")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.accent)
                        .accessibilityAddTraits(.isHeader)

                    Text("1. Bruk appen på en ansvarlig måte.")
                        .font(.body)

                    Text("2. Ikke legg inn sensitiv informasjon som ikke er nødvendig.")
                        .font(.body)

                    Text("3. Saker skal beskrives tydelig og saklig.")
                        .font(.body)

                    Text("4. Appen er et skoleprosjekt og ikke en ferdig kommersiell tjeneste.")
                        .font(.body)
                }

                AppKort {
                    Text("Personvern")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.primary)
                        .accessibilityAddTraits(.isHeader)

                    Text("HelpdeskGuard er laget som et skoleprosjekt. Målet er å vise forståelse for utvikling, brukerstøtte, drift og personvern.")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)

                    Text("Brukeren kan når som helst logge ut eller slette brukeren sin fra lokal lagring i appen.")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)
                }

                AppKort {
                    Text("Tilgjengelighet")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.secondary)
                        .accessibilityAddTraits(.isHeader)

                    Text("Appen forsøker å følge grunnleggende prinsipper for universell utforming. Det betyr blant annet tydelige overskrifter, større trykkflater, god kontrast og lett forståelig språk.")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)
                }

                AppFooter()
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Informasjon")
        .navigationBarTitleDisplayMode(.inline)
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}
