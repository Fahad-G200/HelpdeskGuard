//
//  NewTicketView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI
import SwiftData

struct NewTicketView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TicketEntity.date, order: .reverse) private var tickets: [TicketEntity]

    @State private var description: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("Beskriv problemet ditt", text: $description)
                    .textFieldStyle(.roundedBorder)

                Button("Lagre sak") {
                    let ticket = TicketEntity(descriptionText: description)
                    modelContext.insert(ticket)
                    description = ""
                }
                .buttonStyle(.borderedProminent)
                .disabled(description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                if tickets.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "tray")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)

                        Text("Ingen saker ennå")
                            .font(.headline)

                        Text("Opprett en ny sak ved å skrive en beskrivelse og trykke 'Lagre sak'.")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 24)

                    Spacer()
                } else {
                    List {
                        ForEach(tickets) { ticket in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(ticket.descriptionText)
                                    .font(.headline)

                                Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteTickets)
                    }
                }
            }
            .padding()
            .navigationTitle("Saker")
        }
    }
}

#Preview {
    NewTicketView()
        .modelContainer(for: TicketEntity.self, inMemory: true)
}

