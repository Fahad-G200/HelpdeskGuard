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
        VStack(spacing: 12) {
            Text("Opprett ny sak")
                .font(.title)

            TextField("Beskriv problemet ditt", text: $description)
                .textFieldStyle(.roundedBorder)

            Button("Opprett sak") {
                ticketStore.addTicket(description: description)
                description = ""
            }
        }
        .padding()
    }
}

#Preview {
    NewTicketView()
}

