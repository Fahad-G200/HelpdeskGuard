//
//  TicketsView.swift
//  HelpdeskGuard
//

import SwiftUI

struct TicketsView: View {
    @EnvironmentObject var ticketStore: TicketStore
    @State private var viserNySak = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                Text("Saker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primary)
                    .accessibilityAddTraits(.isHeader)

                if ticketStore.tickets.isEmpty {
                    AppKort {
                        Text("Ingen saker ennå.")
                            .font(.body)
                            .foregroundColor(AppTheme.textPrimary)

                        Text("Trykk på «Ny sak» for å registrere den første saken.")
                            .font(.body)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                } else {
                    VStack(spacing: AppTheme.mediumSpacing) {
                        ForEach(ticketStore.tickets.sorted(by: { $0.date > $1.date })) { ticket in
                            NavigationLink(destination: TicketDetailView(ticketID: ticket.id)) {
                                AppKort {
                                    HStack {
                                        Text(ticket.title)
                                            .font(.headline)
                                            .foregroundColor(AppTheme.textPrimary)
                                        Spacer()
                                        Text(ticket.isResolved ? "Løst" : "Åpen")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(ticket.isResolved ? AppTheme.secondary : AppTheme.primary)
                                    }

                                    Text("\(ticket.category) • \(ticket.priority)")
                                        .font(.subheadline)
                                        .foregroundColor(AppTheme.textSecondary)

                                    Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                AppFooter()
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Saker")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Ny sak") {
                    viserNySak = true
                }
            }
        }
        .sheet(isPresented: $viserNySak) {
            NavigationStack {
                NewTicketView()
                    .navigationTitle("Ny sak")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Lukk") {
                                viserNySak = false
                            }
                        }
                    }
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}

