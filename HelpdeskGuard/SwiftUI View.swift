//
//  SwiftUI View.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import SwiftUI
import SwiftData

struct TicketsView: View {
    // Henter alle saker fra databasen, sortert nyeste først
    @Query(sort: \TicketEntity.date, order: .reverse) private var tickets: [TicketEntity]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.spacing) {

                    Text("Saker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primary)
                        .padding(.horizontal)
                        .accessibilityAddTraits(.isHeader)

                    // Knapp for å opprette ny sak
                    NavigationLink(destination: NewTicketView()) {
                        Text("+ Ny sak")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                    .padding(.horizontal)

                    if tickets.isEmpty {
                        AppKort {
                            Text("Ingen saker registrert ennå.")
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Trykk på '+ Ny sak' for å opprette en sak.")
                                .font(.caption)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(.horizontal)
                    } else {
                        ForEach(tickets) { ticket in
                            AppKort {
                                // Tittel og status
                                HStack {
                                    Text(ticket.title)
                                        .font(.headline)
                                        .foregroundColor(AppTheme.primary)
                                    Spacer()
                                    Text(ticket.isResolved ? "✅ Løst" : "🔴 Åpen")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                }

                                // Beskrivelse
                                Text(ticket.descriptionText)
                                    .font(.body)
                                    .foregroundColor(AppTheme.textPrimary)

                                // Kategori og prioritet
                                HStack {
                                    Text("Kategori: \(ticket.category)")
                                        .font(.caption)
                                        .foregroundColor(AppTheme.textSecondary)
                                    Spacer()
                                    Text("Prioritet: \(ticket.priority)")
                                        .font(.caption)
                                        .foregroundColor(AppTheme.textSecondary)
                                }

                                // Dato
                                Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption2)
                                    .foregroundColor(AppTheme.textSecondary)

                                // Knapp: marker som løst eller åpen
                                Button(ticket.isResolved ? "Marker som åpen" : "Marker som løst") {
                                    ticket.isResolved.toggle()
                                }
                                .buttonStyle(StorKnapp(
                                    bakgrunnsfarge: ticket.isResolved ? AppTheme.accent : AppTheme.secondary
                                ))
                            }
                            .padding(.horizontal)
                        }
                        .onDelete { indexSet in
                            // Slett sak fra databasen
                            for index in indexSet {
                                context.delete(tickets[index])
                            }
                        }
                    }

                    AppFooter()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(AppTheme.background.ignoresSafeArea())
            .navigationTitle("Saker")
            .navigationBarTitleDisplayMode(.inline)
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}

#Preview {
    TicketsView()
        .modelContainer(for: TicketEntity.self, inMemory: true)
}

