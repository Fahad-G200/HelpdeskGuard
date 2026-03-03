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

struct TicketsView: View {
    @EnvironmentObject var ticketStore: TicketStore

    var body: some View {
        NavigationStack {
            List {
                
                ForEach(Array(ticketStore.tickets.enumerated()), id: \.offset) { index, ticket in
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sak \(index + 1)")
                            .font(.headline)

                        Text(ticket.description)
                            .font(.body)

                        Text(ticket.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 6)                }
            }
            .navigationTitle("Saker")
        }
    }
}

#Preview {
    TicketsView()
        .environmentObject(TicketStore())
}

