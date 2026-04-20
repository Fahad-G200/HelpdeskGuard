//
//  SwiftUI View.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

//
//  SwiftUI View.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import SwiftUI
import SwiftData

struct TicketsView: View {
    @Query(sort: \TicketEntity.date, order: .reverse) private var tickets: [TicketEntity]

    var body: some View {
        NavigationStack {
            List {
                if tickets.isEmpty {
                    Text("Ingen saker registrert ennå.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(tickets) { ticket in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ticket.tittel)
                                .font(.headline)
                            Text(ticket.descriptionText)
                                .font(.body)
                                .lineLimit(2)
                            HStack {
                                Text(ticket.kategori)
                                Text("·")
                                Text(ticket.prioritet)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Mine saker")
        }
    }
}

#Preview {
    TicketsView()
        .modelContainer(for: TicketEntity.self, inMemory: true)
}



