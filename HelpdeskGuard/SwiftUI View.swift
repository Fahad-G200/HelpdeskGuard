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
                ForEach(Array(tickets.enumerated()), id: \.offset) { index, ticket in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sak \(index + 1)")
                            .font(.headline)

                        Text(ticket.descriptionText)
                            .font(.body)

                        Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Saker")
        }
    }
}

#Preview {
    TicketsView()
        .modelContainer(for: TicketEntity.self, inMemory: true)
}



