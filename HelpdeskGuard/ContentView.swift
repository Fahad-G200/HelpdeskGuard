//
//  ContentView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authStore: AuthStore
    @State private var valgtFane = 0
    @State private var viserMeny = false
    @State private var visSlettBrukerAlert = false

    var body: some View {
        NavigationStack {
            if authStore.isLoggedIn {
                TabView(selection: $valgtFane) {
                    HomeView()
                        .tabItem {
                            Label("Hjem", systemImage: "house.fill")
                        }
                        .tag(0)

                    TicketsView()
                        .tabItem {
                            Label("Saker", systemImage: "ticket.fill")
                        }
                        .tag(1)

                    kontoView
                        .tabItem {
                            Label("Konto", systemImage: "person.crop.circle")
                        }
                        .tag(2)
                }
                .tint(AppTheme.primary)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            viserMeny = true
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                                .foregroundColor(AppTheme.primary)
                                .padding(8)
                                .accessibilityHidden(true)
                        }
                        .buttonStyle(.plain)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Åpne meny")
                    }
                }
                .sheet(isPresented: $viserMeny) {
                    menyView
                }
                .alert("Slette bruker?", isPresented: $visSlettBrukerAlert) {
                    Button("Slett bruker", role: .destructive) {
                        authStore.deleteCurrentUser()
                    }

                    Button("Avbryt", role: .cancel) {
                    }
                } message: {
                    Text("Er du sikker på at du vil slette brukeren? Denne handlingen kan ikke angres.")
                }
            } else {
                LoginView()
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility5)
    }

    var kontoView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.largeSpacing) {
                Text("Konto")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primary)
                    .accessibilityAddTraits(.isHeader)

                AppKort {
                    Text("Innlogget bruker")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.primary)

                    Text(authStore.currentEmail ?? "Ingen bruker funnet")
                        .font(.body)
                        .foregroundColor(AppTheme.textPrimary)
                }

                AppKort {
                    Text("Kontovalg")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.secondary)

                    Button("Logg ut") {
                        authStore.logout()
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.primary))
                    .accessibilityHint("Logger ut brukeren fra appen")

                    Button("Slett bruker") {
                        visSlettBrukerAlert = true
                    }
                    .buttonStyle(StorKnapp(bakgrunnsfarge: AppTheme.danger))
                    .accessibilityHint("Sletter brukeren fra lokal lagring etter bekreftelse")
                }

                AppFooter()
            }
            .padding()
        }
        .background(AppTheme.background.ignoresSafeArea())
    }

    var menyView: some View {
        NavigationStack {
            List {
                Button {
                    valgtFane = 0
                    viserMeny = false
                } label: {
                    Label("Hjem", systemImage: "house.fill")
                }

                Button {
                    valgtFane = 1
                    viserMeny = false
                } label: {
                    Label("Saker", systemImage: "ticket.fill")
                }

                NavigationLink(destination: InfoView()) {
                    Label("Informasjon og personvern", systemImage: "info.circle.fill")
                }

                NavigationLink(destination: FAQView()) {
                    Label("FAQ – Spørsmål og svar", systemImage: "questionmark.circle.fill")
                }

                Button {
                    authStore.logout()
                    viserMeny = false
                } label: {
                    Label("Logg ut", systemImage: "arrow.backward.circle.fill")
                        .foregroundColor(AppTheme.danger)
                }
            }
            .navigationTitle("Meny")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

