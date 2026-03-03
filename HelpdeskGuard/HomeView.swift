//
//  HomeView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {

                // Tittel + forklaring (header)
                Text("HelpdeskGuard")
                    .font(.largeTitle)
                    .bold()

                Text("Rapporter et problem, så blir det registrert som en sak du kan følge opp.")
                    .foregroundStyle(.secondary)

                // Et “kort” som ser mer profesjonelt ut
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hva vil du gjøre nå?")
                        .font(.headline)

                    Text("Trykk på knappen under for å opprette en ny sak.")
                        .foregroundStyle(.secondary)

                    NavigationLink {
                        NewTicketView()
                    } label: {
                        Text("Opprett ny sak")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Spacer()
            }
            .padding()
            .navigationTitle("Hjem")
        }
    }
}

#Preview {
    HomeView()
}

