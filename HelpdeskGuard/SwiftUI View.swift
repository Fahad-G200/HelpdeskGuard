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
                    
                    Text("Sak \(index + 1): \(String(describing: ticket))")
                }
            }
            .navigationTitle("Saker")
        }
    }
}

#Preview {
    TicketsView()
        .environmentObject(TicketStore())
}

