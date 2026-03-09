//
//  ContentView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Hjem", systemImage: "house")
                }

            TicketsView()
                .tabItem {
                    Label("Saker", systemImage: "tray.full")
                }

            RegisterView()
                .tabItem {
                    Label("Registrer", systemImage: "person.badge.plus")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TicketStore())
        .environmentObject(AuthStore())
}

