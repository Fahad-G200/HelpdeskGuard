//
//  NewTicketView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct NewTicketView: View {
    @EnvironmentObject var ticketStore: TicketStore
    @State private var description: String = ""

    var body: some View {
        NavigationStack {
            if ticketStore.tickets.isEmpty {
                VStack(spacing: 12) {

                    Image(systemName: "tray")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)

                    Text("Ingen saker ennå")
                        .font(.headline)

                    Text("Opprett en ny sak fra Hjem-siden.")
                        .foregroundStyle(.secondary)

                    TextField("Beskriv problemet ditt", text: $description)
                        .textFieldStyle(.roundedBorder)

                    Button("Lagre sak") {
                        ticketStore.addTicket(description: description)
                        description = ""
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding()

            } else {

                List(Array(ticketStore.tickets.enumerated()), id: \.offset) { _, ticket in

                    VStack(alignment: .leading, spacing: 4) {

                        Text(ticket.description)
                            .font(.headline)

                        Text("")
                    }
                    .padding(.vertical, 4)

                }
            }
        }
        .navigationTitle("Saker")
    }
}

#Preview {
    NewTicketView()
        .environmentObject(TicketStore())
}

