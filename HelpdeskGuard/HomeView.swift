//
//  HomeView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var melding: String = "Dette er Hjem-siden"

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Text(melding)

                Text("Velkommen til HelpdeskGuard")
                    .foregroundStyle(.secondary)

                NavigationLink("Opprett ny sak", destination: NewTicketView())
            }
            .padding()
            .navigationTitle("Hjem")
        }
    }
}

#Preview {
    HomeView()
}
