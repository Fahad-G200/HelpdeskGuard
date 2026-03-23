//
//  HomeView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Velkommen til HelpdeskGuard")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primary)
                            .accessibilityAddTraits(.isHeader)

                        Text("En enkel helpdesk-app for registrering av IT-problemer, informasjon og støtte.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    AppKort {
                        Text("Hva kan du gjøre her?")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(AppTheme.primary)
                            .accessibilityAddTraits(.isHeader)

                        Text("• Opprette en ny sak")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)

                        Text("• Lese informasjon om personvern og regler")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)

                        Text("• Bruke appen som en enkel skoleversjon av et helpdesk-system")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    AppKort {
                        Text("Viktig informasjon")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(AppTheme.secondary)
                            .accessibilityAddTraits(.isHeader)

                        Text("Denne appen er en prototype laget som skoleprosjekt. Løsningen er versjon 1.0 og kan bygges videre ut senere.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    AppKort {
                        Text("Tilgjengelighet")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(AppTheme.accent)
                            .accessibilityAddTraits(.isHeader)

                        Text("Appen bruker tydelige overskrifter, store trykkflater og lett språk for å være enklere å bruke for flere.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)
                    }

                    NavigationLink {
                        NewTicketView()
                    } label: {
                        Text("Gå til ny sak")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                    .accessibilityHint("Åpner siden for å registrere en ny sak")

                    NavigationLink {
                        InfoView()
                    } label: {
                        Text("Les informasjon og personvern")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.secondary))
                    .accessibilityHint("Åpner informasjonssiden")

                    AppFooter()
                }
                .padding()
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Hjem")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
