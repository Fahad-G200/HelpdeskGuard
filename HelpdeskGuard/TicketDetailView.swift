//
//  TicketDetailView.swift
//  HelpdeskGuard
//

import SwiftUI

struct TicketDetailView: View {
    @EnvironmentObject var ticketStore: TicketStore
    let ticketID: UUID

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                if let ticket = ticketStore.ticket(for: ticketID) {
                    AppKort {
                        Text(ticket.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primary)

                        Text(ticket.description)
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)

                        Text("Kategori: \(ticket.category)")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)

                        Text("Prioritet: \(ticket.priority)")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)

                        Text("Status: \(ticket.isResolved ? "Løst" : "Åpen")")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(ticket.isResolved ? AppTheme.secondary : AppTheme.primary)

                        Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundColor(AppTheme.textSecondary)
                    }

                    Button(ticket.isResolved ? "Saken er løst" : "Marker som løst") {
                        ticketStore.markTicketAsResolved(id: ticketID)
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: ticket.isResolved ? AppTheme.secondary : AppTheme.primary))
                    .disabled(ticket.isResolved)
                    .accessibilityHint(ticket.isResolved ? "Saken er allerede markert som løst" : "Markerer saken som løst")
                } else {
                    AppKort {
                        Text("Fant ikke saken.")
                            .font(.body)
                            .foregroundColor(AppTheme.danger)
                    }
                }
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Saksdetaljer")
        .navigationBarTitleDisplayMode(.inline)
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}
