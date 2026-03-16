//
//  ContentView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var authStore: AuthStore

    var body: some View {
        if authStore.isLoggedIn {
            appInnhold
        } else {
            LoginView()
        }
    }

    private var appInnhold: some View {
        TabView {

            HomeView()
                .tabItem {
                    Label("Hjem", systemImage: "house")
                }

            TicketsView()
                .tabItem {
                    Label("Saker", systemImage: "tray.full")
                }

            innstillingerFane
                .tabItem {
                    Label("Konto", systemImage: "person.circle")
                }
        }
    }

    private var innstillingerFane: some View {
        VStack(spacing: 20) {

            Spacer()

            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            if let email = authStore.currentEmail {
                Text("Innlogget som:")
                    .foregroundStyle(.secondary)

                Text(email)
                    .font(.headline)
            }

            Spacer()

            Button(role: .destructive) {
                authStore.logout()
            } label: {
                Label("Logg ut", systemImage: "rectangle.portrait.and.arrow.right")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Konto")
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthStore())
        .environmentObject(TicketStore())
}
