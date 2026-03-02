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
            Text("Hjem")
                .tabItem {
                    Label("Hjem", systemImage: "house")
                }
            Text("Saker")
                .tabItem {
                    Label("Saker", systemImage: "tray.full")
                }
        }
    }
}

#Preview {
    ContentView()
}

